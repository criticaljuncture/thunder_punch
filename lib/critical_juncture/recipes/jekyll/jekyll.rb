Capistrano::Configuration.instance(:must_exist).load do |configuration|
  
   namespace :jekyll do
     desc "Build static files from jekyll files"
     task :build do
       alert_user "Building static files from jekyll files"
       run_locally "jekyll"
     end

     desc "Create site (less and jekyll)"
     task :create do
       alert_user "[START] Creating site [START]"
       find_and_execute_task('less:build')
       find_and_execute_task('jekyll:build')
       alert_user "[END] Creating site [END]"
     end
   end
  
end