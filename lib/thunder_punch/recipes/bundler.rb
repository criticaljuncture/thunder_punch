Capistrano::Configuration.instance(:must_exist).load do
  _cset :bundler_roles, [:app]

  namespace :bundler do
    desc "Install and lock bundle"
    task :bundle, :roles => bundler_roles do
      _cset(:excluded_gem_file_groups) { [:development, :test] }
      excluded_groups = gem_file_groups.reject{|e| e == rails_env.to_sym}.each{|g| g.to_s}.join(' ') 
      run "cd #{current_path} && bundle install --deployment --without #{excluded_groups}"
    end
  end
end
