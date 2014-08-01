Capistrano::Configuration.instance(:must_exist).load do
  _cset :db_migration_roles, [:db]

  namespace :deploy do
    task :migrate, :roles => db_migration_roles, :only => { :primary => true } do
      directory = case migrate_target.to_sym
        when :current then current_path
        when :latest  then current_release
        else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
        end

      run "cd #{directory}; #{rake} RAILS_ENV=#{rails_env} db:migrate"
    end
  end #namespace
end
