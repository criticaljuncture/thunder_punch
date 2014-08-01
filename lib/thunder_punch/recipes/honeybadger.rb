Capistrano::Configuration.instance(:must_exist).load do
  _cset :honeybadger_roles, [:app]

  namespace :honeybadger do
    task :notify_deploy, :roles => honeybadger_roles do
      run "cd #{current_path} && #{rake} honeybadger:deploy RAILS_ENV=#{rails_env} TO=#{branch} USER=#{honeybadger_user} REVISION=#{real_revision} REPO=#{repository}"
    end
  end
end
