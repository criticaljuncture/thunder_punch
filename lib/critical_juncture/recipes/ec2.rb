Dir["#{File.dirname(__FILE__)}/ec2/*.rb"].each { |lib|
  Capistrano::Configuration.instance.load {load(lib)}
}