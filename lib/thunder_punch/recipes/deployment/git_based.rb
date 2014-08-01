Capistrano::Configuration.instance(:must_exist).load do
  ssh_options[:paranoid] = false
  default_run_options[:pty] = true

  # In a git based deployment scheme set everything to be current path
  set(:latest_release)  { fetch(:current_path) }
  set(:release_path)    { fetch(:current_path) }
  set(:current_release) { fetch(:current_path) }

  set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
  set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
  set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

  set :migrate_target, :current

  # defaults but you can override if needed
  _cset :use_sudo, true

  # This will execute the Git revision parsing on the *remote* server rather than locally
  _cset :real_revision, lambda { source.query_revision(revision) { |cmd| capture(cmd) } }
  _cset :git_enable_submodules, false


  # don't need these with asset pipeline, etc
  _cset :finalize_deploy, false
  _cset :normalize_asset_timestamps, false
end
