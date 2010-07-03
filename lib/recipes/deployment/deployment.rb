Capistrano::Configuration.instance(:must_exist).load do
  namespace :deploy do
    desc "Deploy the app"
    task :default, :roles => [:app, :static, :worker] do
      update
      restart
      cleanup
    end

    desc "Setup a GitHub-style deployment."
    task :setup, :roles => [:app, :static, :worker], :except => { :no_release => true } do
      run "git clone #{repository} #{current_path}"
    end

    desc "Update the deployed code."
    task :update_code, :roles => [:app, :static, :worker], :except => { :no_release => true } do
      run "cd #{current_path}; git fetch origin; git reset --hard #{branch}; git submodule update --init"
    end
    
    # "rollback" is actually a namespace with a default task
    namespace :rollback do
      desc "Rollback a single commit."
      task :code, :roles => [:app, :static, :worker], :except => { :no_release => true } do
        set :branch, "HEAD^"
        deploy.default
      end

      task :default, :roles => [:app, :static, :worker] do
        rollback.code
      end
    end
    
  end
  
  #############################################################
  # Set Rake Path
  #############################################################

  namespace :deploy do
    desc "Set rake path"
    task :set_rake_path, :roles => [:app, :worker] do
      run "which rake" do |ch, stream, data|
        if stream == :err
          abort "captured output on STDERR when setting rake path: #{data}"
        elsif stream == :out
          set :rake_path, data.to_s.strip
        end
      end
    end
  end
  

  # Turn of capistrano's restart in favor of passenger restart
  namespace :deploy do
    desc "Remove deploy:restart In Favor Of passenger:restart Task"
    task :restart do
    end
  end
  
end