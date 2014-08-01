# in lib/assets_version.rb
# https://gist.github.com/afcapel/7cf9f46fbc56be6f8512
require 'yaml'
require 'English'
require 'ostruct'

class AssetsVersion < OpenStruct

  REVISIONS_FILE = "config/assets_version.yml"

  ASSETS_DEPENDENCIES = {
    'gemfile_lock' => 'Gemfile.lock',
    'assets_dir'   => 'app/assets',
    'vendor_dir'   => 'vendor',
  }

  def self.needs_precompile?
    @last    = last_version
    @current = current

    @last.incomplete? || @current.incomplete? || @current != @last
  end

  def self.last_version
    revisions = load_revisions_from_yaml_file
    AssetsVersion.new(revisions)
  end

  def self.current
    revisions = {}

    ASSETS_DEPENDENCIES.each do |key, file|
      revisions[key] = git_revision_for(file)
    end

    AssetsVersion.new(revisions)
  end

  def self.load_revisions_from_yaml_file
    YAML.load_file(REVISIONS_FILE)
  rescue
    Hash.new
  end

  def self.git_revision_for(file)
    rev = `git log -n 1 --format="%H" #{file}`

    $CHILD_STATUS.success? ? rev.strip : nil
  end

  def save_to_yaml
    File.open(REVISIONS_FILE, "w") { |f| f.write(to_json) }
  end

  def incomplete?
    revisions = ASSETS_DEPENDENCIES.keys.collect { |k| send(k) }
    revisions.any?(&:nil?) || revisions.any?(&:empty?)
  end

  def to_json
    YAML.to_json(marshal_dump)
  end
end
