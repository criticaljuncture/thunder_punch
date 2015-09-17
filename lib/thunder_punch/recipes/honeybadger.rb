Capistrano::Configuration.instance(:must_exist).load do
  _cset :honeybadger_roles, [:app]

  namespace :honeybadger do
    task :notify_deploy, :roles => honeybadger_roles do
      run "cd #{current_path} && #{rake} honeybadger:deploy RAILS_ENV=#{rails_env} TO=#{branch} USER=#{honeybadger_user} REVISION=#{real_revision} REPO=#{repository}"
    end
  end

  namespace :honeybadger_cli do
    task :notify_deploy, :roles => honeybadger_roles do
      api_key = fetch(:honeybadger_api_key_var, "$HONEYBADGER_API_KEY")
      precommand = fetch(:honeybadger_cli_precommand, "")

      cmds = ["cd #{current_path}"]
      cmds << precommand if precommand != ""
      cmds << "bundle exec honeybadger deploy -e #{rails_env} -r #{repository} -s #{real_revision} -u #{honeybadger_user} -k #{api_key}"

      run "#{cmds.join(' && ')}"
    end

    namespace :dotenv do
      task :notify_deploy, :roles => honeybadger_roles do
        api_key = fetch(:honeybadger_api_key_var, "$HONEYBADGER_API_KEY")
        precommand = fetch(:honeybadger_cli_precommand, "")

        cmds = ["cd #{current_path}"]
        cmds << precommand if precommand != ""
        cmds << "bundle exec dotenv ./honeybadger_cli.sh #{rails_env} #{repository} #{real_revision} #{honeybadger_user} #{api_key}"

        run "#{cmds.join(' && ')}"
      end
    end
  end
end
