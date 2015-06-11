require 'config_service'
require 'active_support/json'
DEPLOY_CONFIG = ConfigService.load_config('deploy/deploy_config.yml')
DEPLOY_ENV =  ENV['cap_env'] || ARGV[0]

DEPLOY_SSH_KEYS     = DEPLOY_CONFIG[DEPLOY_ENV]['ssh_keys']
DEPLOY_APPLICATION  = DEPLOY_CONFIG[DEPLOY_ENV]['application']
DEPLOY_REPO_URL     = DEPLOY_CONFIG[DEPLOY_ENV]['repo_url']
DEPLOY_BRANCH       = (ENV['branch'].to_s.strip != '')? ENV['branch'] : DEPLOY_CONFIG[DEPLOY_ENV]['branch']
DEPLOY_RVM_BIN_PATH = DEPLOY_CONFIG[DEPLOY_ENV]['rvm_bin_path']
DEPLOY_USER         = DEPLOY_CONFIG[DEPLOY_ENV]['deploy_user']
DEPLOY_TO_DIR       = DEPLOY_CONFIG[DEPLOY_ENV]['deploy_to_dir']
DEPLOY_PRODUCTION   = DEPLOY_CONFIG[DEPLOY_ENV]['deploy_production']
DEPLOY_GEM_FILE     = DEPLOY_CONFIG[DEPLOY_ENV]['bundle_gem_file']
EMAIL_ALERT_TO      = DEPLOY_CONFIG[DEPLOY_ENV]['email_alert_to']
UNICORN_PID         = DEPLOY_CONFIG[DEPLOY_ENV]['unicorn_pid']
NUMBER_OF_WORKERS   = DEPLOY_CONFIG[DEPLOY_ENV]['number_of_workers']

set :rack_env, DEPLOY_ENV
set :stage, DEPLOY_ENV

deploy_to_hosts = []
if (ENV['targets'].to_s.strip != '')
  # targets is {"app"=>["nobody@localhost"], "db"=>["nobody@localhost"]}.to_json
  begin
    targets = ActiveSupport::JSON.decode(ENV['targets'])
  rescue => exc
    puts "ERROR parsing targets #{ENV['targets'].inspect}: #{exc.message}"
    exit
  end
else
  targets = DEPLOY_CONFIG[DEPLOY_ENV]['roles']
end

targets.each do |role, user_hosts|
  role role, user_hosts
  user_hosts.each { |info| deploy_to_hosts << info.split('@').last } 
end

DEPLOY_TO_HOSTS = deploy_to_hosts.uniq

# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require 'capistrano/bundler'
require 'capistrano/console'
require 'capistrano/rvm'
require 'capistrano/puma'
# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
