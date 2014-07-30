Capistrano::Configuration.instance(:must_exist).load do
  _cset :varnish_roles, [:app]

  namespace :varnish do
    desc "Clear the entire varnish cache ('.*')"
    task :clear_cache, :roles => varnish_roles do
      sudo 'varnishadm -T localhost:6082 purge.url ".*"'
    end
  end
end
