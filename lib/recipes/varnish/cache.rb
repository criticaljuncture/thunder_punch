Capistrano::Configuration.instance(:must_exist).load do
  
  namespace :varnish do
    
    desc "Generate the compiled CSS files from Sass"
    task :clear_cache, :roles => [:proxy] do
      sudo 'varnishadm -T localhost:6082 purge.url ".*"'
    end
    
  end # end namespace
  
end