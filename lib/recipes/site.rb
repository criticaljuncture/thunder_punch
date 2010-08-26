Capistrano::Configuration.instance(:must_exist).load do

  namespace :site do
    desc "Serve up a custom maintenance page."
    task :disable, :roles => [:app] do
      require 'erb'
      on_rollback { delete "#{shared_path}/system/maintenance.html" }
      reason   = ENV['REASON' ]
      deadline = ENV['UNTIL' ]

      template = File.join(File.dirname(__FILE__), "..", "..", "..", "files", 'app', 'maintenance.html.erb')
      page     = ERB.new(File.read(template)).result(binding)
      
      upload_string page, "#{shared_path}/system/maintenance.html", :via => :scp, :mode => 644
    end
    
    desc "Serve up a custom maintenance page."
    task :enable, :roles => :web do
      run "rm #{shared_path}/system/maintenance.html"
    end
  end #end namespace

end