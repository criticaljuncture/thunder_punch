# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "thunder_punch"
  s.version = "0.0.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bob Burbach"]
  s.date = "2013-01-08"
  s.description = "Collection of capistano recipes for deployment and server tasks"
  s.email = "info@criticaljuncture.org"
  s.extra_rdoc_files = [
    "README.mdown"
  ]
  s.files = [
    ".document",
    "CHANGELOG.mdown",
    "MIT-LICENSE",
    "Manifest",
    "README.mdown",
    "Rakefile",
    "TODO.mdown",
    "VERSION",
    "example/amazon.yml",
    "files/app/maintenance.html.erb",
    "lib/recipes.rb",
    "lib/recipes/bundler.rb",
    "lib/recipes/database.rb",
    "lib/recipes/deployment.rb",
    "lib/recipes/deployment/deployment.rb",
    "lib/recipes/deployment/migration.rb",
    "lib/recipes/deployment/passenger.rb",
    "lib/recipes/deployment/symlinks.rb",
    "lib/recipes/ec2.rb",
    "lib/recipes/ec2/ami.rb",
    "lib/recipes/jekyll/jekyll.rb",
    "lib/recipes/less/less.rb",
    "lib/recipes/sass.rb",
    "lib/recipes/sass/compile.rb",
    "lib/recipes/site.rb",
    "lib/recipes/thinking_sphinx.rb",
    "lib/recipes/varnish.rb",
    "lib/recipes/varnish/cache.rb",
    "lib/thunder_punch.rb",
    "lib/utilities/utilities.rb",
    "test/helper.rb",
    "test/test_thunder_punch.rb",
    "thunder_punch.gemspec"
  ]
  s.homepage = "http://github.com/critical/thunder_punch"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Collection of capistano recipes for deployment and server tasks"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<capistrano>, [">= 2.5.5"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<capistrano>, [">= 2.5.5"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<capistrano>, [">= 2.5.5"])
  end
end

