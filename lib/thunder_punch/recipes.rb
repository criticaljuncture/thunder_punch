default_recipes = %w(bundler deployment)

default_recipes.each do |recipe|
  Capistrano::Configuration.instance.load {
    load("#{File.dirname(__FILE__)}/recipes/#{recipe}.rb")
  }
end
