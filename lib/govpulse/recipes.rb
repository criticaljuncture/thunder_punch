Dir["#{File.dirname(__FILE__)}/recipes/*.rb"].each { |lib|
  Capistrano::Configuration.instance.load {load(lib)}
}