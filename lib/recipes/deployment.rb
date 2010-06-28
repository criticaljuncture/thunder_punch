Dir["#{File.dirname(__FILE__)}/deployment/*.rb"].each { |lib|
  Capistrano::Configuration.instance.load {load(lib)}
}