Capistrano::Configuration.instance(:must_exist).load do
  _cset :sass_roles, [:app]

  #this is pre-asset pipeline days - left in for backwards compatibility
  namespace :sass do
    desc "Generate (force) the compiled CSS files from Sass"
    task :update_stylesheets, :roles => sass_roles do
      run "cd #{current_path}; script/runner -e #{rails_env} 'Sass::Plugin.options[:always_update] = 1; Sass::Plugin.update_stylesheets'"
    end
  end
end
