Capistrano::Configuration.instance(:must_exist).load do
  # these are the usual suspects (for rails)
  set :standard_symlinks, {
    'log'                 => 'log',
    'config/database.yml' => 'config/database.yml',
    'public/system'       => 'system',
    'tmp'                 => 'tmp'
  }
  
  # these are project specific but still reside in shared
  # e.g., 'backups' => 'db/backups'
  #     ==>  rm -rf #{release_path}/backups && ln -s #{shared_path}/db/backups #{release_path}/backups
  _cset :custom_symlinks, {}
  
  # these are project specific but need full 'from' paths
  # eg 'foo' => '/var/www/apps/project/foo'
  # creates the command "rm -rf #{release_path}/foo && ln -s /var/www/apps/project/foo #{release_path}/foo"
  _cset :other_symlinks, {}
 
  namespace :symlinks do
    desc "Create all sylinks (removes directories/files if they exist first)"
    task :create, :roles => [:app, :worker], :except => { :no_release => true } do
 
      commands = standard_symlinks.map do |to, from|
        "rm -rf #{current_path}/#{to} && ln -s #{shared_path}/#{from} #{current_path}/#{to}"
      end
      
      commands += custom_symlinks.map do |to, from|
        "rm -rf #{current_path}/#{to} && ln -s #{shared_path}/#{from} #{current_path}/#{to}"
      end
      
      commands += other_symlinks.map do |to, from|
        "rm -rf #{current_path}/#{to} && ln -s #{from} #{current_path}/#{to}"
      end
 
      run "cd #{current_path} && #{commands.join(" && ")}"
    end
  end
end
