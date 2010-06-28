unless Capistrano::Configuration.respond_to?(:instance)
  abort "Requires Capistrano 2"
end
 
%w(recipes).each do |filename| 
  Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/#{filename}.rb")}
end

Dir["#{File.dirname(__FILE__)}/utilities/*.rb"].each { |lib|
  Capistrano::Configuration.instance.load {load(lib)}
}