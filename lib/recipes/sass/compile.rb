Capistrano::Configuration.instance(:must_exist).load do
  
  namespace :sass do
    
    desc "Generate the compiled CSS files from Sass"
    task :update_stylesheets, :roles => [:static] do
      run "cd #{current_path}; script/runner -e #{rails_env} 'Sass::Plugin.update_stylesheets'"
    end
    
  end # end namespace
  
end