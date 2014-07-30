Capistrano::Configuration.instance(:must_exist).load do

  #finalizing deploy is normal behaviour but in some (multi-server) environments we don't want that.
  _cset :finalize_deploy, true
  # set rake path if not set
  _cset :rake, "bundle exec rake"
  # set default roles for the deploy task
  _cset :deploy_roles, [:app]

  namespace :deploy do
    desc "Deploy the app"
    task :default, :roles => deploy_roles do
      update
      restart
    end

    desc "Setup a GitHub-style deployment."
    task :setup, :roles => deploy_roles, :except => { :no_release => true } do
      run "cd #{deploy_to} && git clone #{repository} #{current_path}"
    end

    task :update do
      transaction do
        update_code
      end
    end

    desc "Update the deployed code."
    task :update_code, :roles => deploy_roles, :except => { :no_release => true } do
      run "cd #{current_path}; git fetch origin; git reset --hard origin/#{branch}; git submodule update --init"
      if fetch(:finalize_deploy, true)
        finalize_update
      end
    end

    desc "Update the database (overwritten to avoid symlink)"
    task :migrations do
      transaction do
        update_code
      end
      migrate
    end


    # "rollback" is actually a namespace with a default task
    # we overwrite the default task below to get our new behavior
    namespace :rollback do
      desc "Moves the repo back to the previous version of HEAD"
      task :repo, :except => { :no_release => true }, :roles => deploy_roles do
        set :branch, "HEAD@{1}"
        deploy.default
      end

      desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
      task :cleanup, :except => { :no_release => true }, :roles => deploy_roles do
        run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
      end

      desc "Rolls back to the previously deployed version."
      task :default do
        rollback.repo
        rollback.cleanup
      end
    end

  end

  #############################################################
  # Set Rake Path
  #############################################################

  namespace :deploy do
    desc "Set rake path"
    task :set_rake_path, :roles => deploy_roles do
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
