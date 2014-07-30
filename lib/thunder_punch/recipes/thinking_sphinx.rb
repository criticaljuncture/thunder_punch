Capistrano::Configuration.instance(:must_exist).load do
  _cset :thinking_sphinx_roles, [:app]

  namespace :thinking_sphinx do
    desc "Generate the Sphinx configuration file"
    task :configure, :roles => thinking_sphinx_roles do
      rake "thinking_sphinx:configure"
    end

    desc "Index data"
    task :index, :roles => thinking_sphinx_roles do
      rake "thinking_sphinx:index"
    end

    desc "Start the Sphinx daemon"
    task :start, :roles => thinking_sphinx_roles do
      rake "thinking_sphinx:start"
    end

    desc "Stop the Sphinx daemon"
    task :stop, :roles => thinking_sphinx_roles do
      rake "thinking_sphinx:stop"
    end

    desc "Stop and then start the Sphinx daemon"
    task :restart, :roles => thinking_sphinx_roles do
      stop
      start
    end

    desc "Stop, configure, re-index and then start the Sphinx daemon"
    task :rebuild, :roles => thinking_sphinx_roles  do
      stop
      configure
      index
      start
    end

    desc "Stop, re-index and then start the Sphinx daemon"
    task :reindex, :roles => thinking_sphinx_roles  do
      stop
      index
      start
    end

    desc "Add the shared folder for sphinx files for the production environment"
    task :create_shared_sphinx_folder, :roles => thinking_sphinx_roles do
      run "mkdir -p #{shared_path}/db/sphinx/production"
    end

    def rake(*tasks)
      rails_env = fetch(:rails_env, "production")
      rake = fetch(:rake, "bundle exec rake")
      tasks.each do |t|
        run "if [ -d #{release_path} ]; then cd #{release_path}; else cd #{current_path}; fi; #{rake} RAILS_ENV=#{rails_env} #{t}"
      end
    end
  end
end
