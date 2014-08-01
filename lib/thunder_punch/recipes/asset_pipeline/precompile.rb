Capistrano::Configuration.instance(:must_exist).load do
  _cset :asset_roles, [:app]

  namespace :assets do
    task :precompile_if_needed, :roles => asset_roles do
      precompile_needed = capture "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} assets:precompile_needed"

      if precompile_needed.strip == "true"
        precompile
        save_assets_versions
      end
    end

    task :precompile, :roles => asset_roles do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} assets:precompile"
    end

    task :save_assets_versions, :roles => asset_roles do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} assets:save_assets_versions"
    end
  end
end
