Capistrano::Configuration.instance(:must_exist).load do
  #############################################################
  # Passenger Restart
  #############################################################

  namespace :passenger do
    desc "Restart Application"
    task :restart, :except => { :no_release => true }, :roles => [:app] do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
  
  #############################################################
  # Passenger Status Checks
  #############################################################

  namespace :passenger do
    desc "Check Passenger Status"
    task :status, :roles => [:app] do
      sudo 'passenger-status'
    end

    desc "Check Apache/Passenger Memory Usage"
    task :memory_stats, :roles => [:app] do
      sudo 'passenger-memory-stats'
    end
  end
end