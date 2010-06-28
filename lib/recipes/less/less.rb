Capistrano::Configuration.instance(:must_exist).load do |configuration|

  namespace :less do
    desc "Build css files from .less files"
    task :build do
      _cset :less_directory, '_less'
      _cset :css_directory, 'css'
      Dir.glob(less_directory + '/*.less').each do |file|
        if File.file?(file)
          file_name = file.split('/').last.split('.').first
          alert_user("Creating css file for less file named #{file_name}" )
          run_locally("lessc #{less_directory}/#{file_name}.less #{css_directory}/#{file_name}.css")
        end
      end
    end
  end

end