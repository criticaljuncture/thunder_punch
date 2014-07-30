Capistrano::Configuration.instance(:must_exist).load do
  _cset :site_roles, [:app]

  namespace :site do
    desc "Serve up a custom maintenance page."
    task :disable, :roles => site_roles do
      require 'erb'
      on_rollback { delete "#{shared_path}/system/maintenance.html" }
      reason   = ENV['REASON' ]
      deadline = ENV['UNTIL' ]

      template = File.join(File.dirname(__FILE__), "..", "..", "..", "files", 'app', 'maintenance.html.erb')
      page     = ERB.new(File.read(template)).result(binding)

      upload_string page, "#{shared_path}/system/maintenance.html", :via => :scp, :mode => 644
    end

    desc "Remove custom maintenance page."
    task :enable, :roles => site_roles do
      run "rm #{shared_path}/system/maintenance.html"
    end
  end
end
