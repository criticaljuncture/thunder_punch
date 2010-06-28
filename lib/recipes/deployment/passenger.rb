Capistrano::Configuration.instance(:must_exist).load do
  #############################################################
  # Passenger Restart
  #############################################################

  namespace :passenger, :roles => [:app] do
    desc "Restart Application"
    task :restart do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
  
  #############################################################
  # Passenger Status Checks
  #############################################################

  namespace :passenger, :roles => [:app] do
    desc "Check Passenger Status"
    task :status do
      sudo 'passenger-status'
    end

    desc "Check Apache/Passenger Memory Usage"
    task :memory_stats, :roles => [:app] do
      sudo 'passenger-memory-stats'
    end
  end
end