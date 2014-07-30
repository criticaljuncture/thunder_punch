Dir["#{File.dirname(__FILE__)}/sass/*.rb"].each { |lib|
  Capistrano::Configuration.instance.load {load(lib)}
}