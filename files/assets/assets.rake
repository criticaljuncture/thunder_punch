# in lib/tasks/assets.rb
namespace :assets do
  require_relative '../assets_version'

  task :precompile_needed do
    AssetsVersion.needs_precompile?
  end

  task :save_assets_versions do
    AssetsVersion.current.save_to_yaml
  end
end
