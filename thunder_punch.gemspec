# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{thunder_punch}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bob Burbach"]
  s.date = %q{2010-07-02}
  s.description = %q{Collection of capistano recipes for deployment and server tasks}
  s.email = %q{govpulse@gmail.com}
  s.extra_rdoc_files = [
    "README.mdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "CHANGELOG.mdown",
     "MIT-LICENSE",
     "Manifest",
     "README.mdown",
     "Rakefile",
     "TODO.mdown",
     "VERSION",
     "example/amazon.yml",
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
     "lib/recipes/thinking_sphinx.rb",
     "lib/thunder_punch.rb",
     "lib/utilities/utilities.rb",
     "test/helper.rb",
     "test/test_thunder_punch.rb",
     "thunder_punch.gemspec"
  ]
  s.homepage = %q{http://github.com/trifecta/thunder_punch}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Collection of capistano recipes for deployment and server tasks}
  s.test_files = [
    "test/helper.rb",
     "test/test_thunder_punch.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
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

