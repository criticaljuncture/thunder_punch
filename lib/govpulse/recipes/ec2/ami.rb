Capistrano::Configuration.instance(:must_exist).load do |configuration|

  namespace :ec2 do
    _cset :ec2_config_loaded, false
    _cset :ec2_config_location, nil
    
    task :load_ec2_config, :roles => :app do
      alert_user('You need to set :ec2_config_location in your deploy file', :abort => true) unless ec2_config_location
      alert_user("You must configure your ec2 settings in config/ec2_config.yml", :abort => true) unless File.exist?(ec2_config_location)
        
      ec2_config = YAML.load( File.open(ec2_config_location, 'r') )
      
      set :aws_key_location,      ec2_config['aws_key_location']
      set :ec2_private_key,       ec2_config['ec2_private_key']
      set :ec2_x509_cert,         ec2_config['ec2_x509_cert']
      set :aws_account_id,        ec2_config['aws_account_id']
      set :ec2_architecture,      ec2_config['ec2_architecture']
      set :aws_access_key,        ec2_config['aws_access_key']
      set :aws_secret_access_key, ec2_config['aws_secret_access_key']
      set :ec2_s3_bucket_name,    ec2_config['ec2_s3_bucket_name']
    
      alert_user('You need to set :aws_key_location in config/ec2_config.yml',                              :abort => true) unless :key_location
      alert_user('You need to set :ec2_private_key in config/ec2_config.yml',                               :abort => true) unless :ec2_private_key 
      alert_user('You need to set :ec2_x509_cert in config/ec2_config.yml',                                 :abort => true) unless :ec2_x509_cert
      alert_user('You need to set :aws_account_id in config/ec2_config.yml',                                :abort => true) unless :aws_account_id
      alert_user('You need to set :ec2_architecture to either "i386" or "x86_64" in config/ec2_config.yml', :abort => true) unless :ec2_architecture
      alert_user('You need to set :aws_access_key in config/ec2_config.yml',                                :abort => true) unless :aws_access_key
      alert_user('You need to set :aws_secret_access_key in config/ec2_config.yml',                         :abort => true) unless :aws_secret_access_key
      alert_user('You need to set :ec2_s3_bucket_name in config/ec2_config.yml',                            :abort => true) unless :ec2_s3_bucket_name
    
      set :ec2_config_loaded, true
    end
  
    desc 'Bundle new AMI, upload to S3, and register'
    task :create_new_ami, :roles => :app do
      load_ec2_config unless ec2_config_loaded
    
      should_copy_keys = Capistrano::CLI.ui.ask "Do you need to copy your keys to the ec2 instance you are creating an AMI from? [Y/n]: "
      while !['Y', 'n'].include?(should_copy_keys)
        puts "\n Please choose Y or n \n"
        should_copy_keys = Capistrano::CLI.ui.ask "Do you need to copy your keys? [Y/n]: "
      end
      copy_keys unless should_copy_keys == 'n'
    
      alert_user("You need to set :bundle_name via the command line\n `cap ec2:create_new_ami -s bundle_name=sample`", :abort => true) unless configuration[:bundle_name]
      bundle_ami
      upload_ami_to_s3
      register_ami
    end  
  
    desc 'Copy private key and X.509 certificate to server'
    task :copy_keys, :roles => :app do
      load_ec2_config unless ec2_config_loaded
      upload "#{aws_key_location}/#{ec2_private_key} #{aws_key_location}/#{ec2_x509_cert} #{user}@#{domain}:/mnt", :via => :scp
    end
  
    desc 'Bundle your AMI (including fstab)'
    task :bundle_ami, :roles => :app do
      load_ec2_config unless ec2_config_loaded
      alert_user("You need to set :bundle_name via the command line\n `cap ec2:bundle_ami -s bundle_name=sample`", :abort => true) unless configuration[:bundle_name]
      sudo "ec2-bundle-vol -d /mnt --fstab /etc/fstab -k /mnt/#{ec2_private_key} -c /mnt/#{ec2_x509_cert} -u #{aws_account_id} -r #{ec2_architecture} -p #{bundle_name}"
    end
  
    desc 'Upload your bundled AMI to S3'
    task :upload_ami_to_s3, :roles => :app do
      load_ec2_config unless ec2_config_loaded
      alert_user("You need to set :bundle_name via the command line\n `cap ec2:upload_to_s3 -s bundle_name=sample`", :abort => true) unless configuration[:bundle_name]
      sudo "ec2-upload-bundle -b #{ec2_s3_bucket_name} -m /mnt/#{bundle_name}.manifest.xml -a #{aws_access_key} -s #{aws_secret_access_key}"
    end
  
    desc 'Register your bundled and upload (to S3) AMI'
    task :register_ami, :roles => :app do
      load_ec2_config unless ec2_config_loaded
      alert_user("You need to set :bundle_name via the command line\n `cap ec2:register_ami -s bundle_name=sample`", :abort => true) unless configuration[:bundle_name]
      run_locally "ec2-register #{ec2_s3_bucket_name}/#{bundle_name}.manifest.xml"
    end
    
  end

end