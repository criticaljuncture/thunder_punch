Capistrano::Configuration.instance(:must_exist).load do

  namespace :bundler do
    desc "Install and lock bundle"
    task :fix_bundle, :roles => [:app, :worker] do
      _cset(:gem_file_groups) { [:development, :production] }
      excluded_groups = gem_file_groups.reject{|e| e == rails_env.to_sym}.each{|g| g.to_s}.join(' ') 
      run "cd #{current_path} && bundle install --deployment --without #{excluded_groups}"
    end
  end
  
end