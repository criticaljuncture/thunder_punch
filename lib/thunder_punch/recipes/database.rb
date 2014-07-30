Capistrano::Configuration.instance(:must_exist).load do
  _cset :database_roles, [:db]

  #############################################################
  # Check for Existing Database
  #############################################################

  namespace :database do
    desc "Check to see if database exists"
    task :check_database_existence, :roles => database_roles, :only => { :primary => true } do
      db_exists = false
      run "mysql -u root -e \"SELECT COUNT(SCHEMA_NAME) FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '#{database_to_check}';\" --batch --reconnect --show-warning --silent" do |ch, stream, data|
        if stream == :err
          abort "capured output on STDERR when verifying database #{database_to_check} exists: #{data}"
        elsif stream == :out
          return_value = data.split("\n").first.chomp

          if ['0','1'].include?(return_value)
            db_exists = return_value == '0' ? false : true
          else
            abort "Invalid response from db when checking if database exists. Expected 0 or 1, got a count of #{return_value}"
          end
          puts db_exists
        end
      end
      db_exists
    end
  end

  #############################################################
  # Backup Database
  #############################################################

  namespace :database do
    desc "Dump the current database"
    task :backup, :roles => database_roles, :only => { :primary => true } do
      set :database_to_check, remote_db_name # used by the check_database_existence task
      db_exists = find_and_execute_task('database:check_database_existence')

      if db_exists
        sudo "sudo mkdir -p #{db_path}"
        run "mysqldump -u root --opt #{remote_db_name} > #{sql_file_path}"
      else
        abort "There is no database named #{remote_db_name} to backup"
      end
    end
  end

  #############################################################
  # Load Remote Staging Database to Local Machine
  #############################################################

  namespace :database do
    desc "Backup remote database and load locally"
    task :load_remote, :roles => database_roles, :only => { :primary => true } do
      backup
      copy
      load_copy
    end

    desc "Copy the current database"
    task :copy, :roles => database_roles, :only => { :primary => true } do
      `mkdir -p tmp`
      download(sql_file_path, "tmp/", :via=> :scp)
    end

    desc "Load the staging database locally"
    task :load_copy, :roles => database_roles, :only => { :primary => true } do
      `rails dbconsole -p < tmp/#{remote_db_name}.sql`
    end
  end
end
