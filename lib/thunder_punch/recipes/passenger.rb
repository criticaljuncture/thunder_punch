Capistrano::Configuration.instance(:must_exist).load do
  _cset :passenger_roles, [:app]

  #############################################################
  # Passenger Restart
  #############################################################

  namespace :passenger do
    desc "Restart Application"
    task :restart, :except => { :no_release => true }, :roles => passenger_roles do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end

  #############################################################
  # Passenger Status Checks
  #############################################################

  namespace :passenger do
    desc "Check Passenger Status"
    task :status, :roles => passenger_roles do
      sudo 'passenger-status'
    end

    desc "Check Apache/Passenger Memory Usage"
    task :memory_stats, :roles => passenger_roles do
      sudo 'passenger-memory-stats'
    end
  end
end
