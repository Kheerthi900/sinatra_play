# config valid only for Capistrano 3.4.0
lock '3.4.0'


puts "\n\e[0;31m   #########################################################################" 
puts "   \n   This is going to deploy '#{DEPLOY_APPLICATION}' environment '#{DEPLOY_ENV}' on\n    #{DEPLOY_TO_HOSTS.join("\n    ")}"
puts "   #########################################################################\e[0m\n" 



set :application, DEPLOY_APPLICATION
set :repo_url, DEPLOY_REPO_URL
set :user, DEPLOY_USER
# Default deploy_to directory is /var/www/my_app
set :deploy_to, DEPLOY_TO_DIR

set :deploy_production, DEPLOY_PRODUCTION

set :branch, DEPLOY_BRANCH
set :scm, :git
set :scm_verbose, true
set :use_sudo, false
set :git_enable_submodules, 1
set :keep_releases, 3
set :deploy_via, :remote_cache

#set :linked_files, %w{env.rb config/database.yml config/postgres-users.yml}
#set :linked_dirs, %w{log tmp config/settings}

set :default_env, {rvm_bin_path: DEPLOY_RVM_BIN_PATH}
set :bundle_flags, '--deployment' 
set :ssh_options, {:forward_agent => true}

set :log_level, :debug

set :linked_files, %w{config/puma.rb config/database.yml}
set :linked_dirs,  %w{bin log}



