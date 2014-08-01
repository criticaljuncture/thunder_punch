Capistrano::Configuration.instance(:must_exist).load do
  _cset :apache_roles, [:app]

  namespace :apache do
    desc "Restart Apache Servers"
    task :restart, :roles => apache_roles do
      sudo '/etc/init.d/apache2 restart'
    end
  end
end
