Capistrano::Configuration.instance.load {
  load("#{File.dirname(__FILE__)}/asset_pipeline/precompile.rb")
}
