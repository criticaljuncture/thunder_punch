Dir["#{File.dirname(__FILE__)}/varnish/*.rb"].each { |lib|
  Capistrano::Configuration.instance.load {load(lib)}
}