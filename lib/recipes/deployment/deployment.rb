Capistrano::Configuration.instance(:must_exist).load do
  namespace :deploy, :roles => [:app, :static] do
    desc "Deploy the app"
    task :default do
      update
      restart
      cleanup
    end

    desc "Setup a GitHub-style deployment."
    task :setup, :except => { :no_release => true } do
      run "git clone #{repository} #{current_path}"
    end

    desc "Update the deployed code."
    task :update_code, :except => { :no_release => true } do
      run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    end

    desc "Rollback a single commit."
    task :rollback, :except => { :no_release => true } do
      set :branch, "HEAD^"
      default
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