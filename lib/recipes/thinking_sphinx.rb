Capistrano::Configuration.instance(:must_exist).load do
  namespace :thinking_sphinx do
  
    desc "Generate the Sphinx configuration file"
    task :configure, :roles => [:app, :worker] do
      rake "thinking_sphinx:configure"
    end
  
    desc "Index data"
    task :index, :roles => :worker do
      rake "thinking_sphinx:index"
    end
  
    desc "Start the Sphinx daemon"
    task :start, :roles => :worker do
      configure
      rake "thinking_sphinx:start"
    end
  
    desc "Stop the Sphinx daemon"
    task :stop, :roles => :worker do
      configure
      rake "thinking_sphinx:stop"
    end
  
    desc "Stop and then start the Sphinx daemon"
    task :restart, :roles => :worker do
      stop
      start
    end
  
    desc "Stop, re-index and then start the Sphinx daemon"
    task :rebuild, :roles => :worker  do
      stop
      index
      start
    end
  
    desc "Add the shared folder for sphinx files for the production environment"
    task :shared_sphinx_folder, :roles => [:app, :worker] do
      run "mkdir -p #{shared_path}/db/sphinx/production"
    end

    def rake(*tasks)
      rails_env = fetch(:rails_env, "production")
      rake = fetch(:rake, "rake")
      tasks.each do |t|
        run "if [ -d #{release_path} ]; then cd #{release_path}; else cd #{current_path}; fi; #{rake} RAILS_ENV=#{rails_env} #{t}"
      end
    end
  end
end
