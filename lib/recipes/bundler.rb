Capistrano::Configuration.instance(:must_exist).load do

  namespace :bundler do
    desc "Install and lock bundle"
    task :fix_bundle, :roles => [:app, :worker] do
      run "cd #{current_path} && bundle install"
    end
  end
  
end