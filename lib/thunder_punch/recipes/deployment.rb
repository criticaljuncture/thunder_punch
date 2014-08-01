# load in a particular order here
deployment_recipes = %w(git_based deployment symlinks migration)

deployment_recipes.each do |recipe|
  Capistrano::Configuration.instance.load {
    load("#{File.dirname(__FILE__)}/deployment/#{recipe}.rb")
  }
end
