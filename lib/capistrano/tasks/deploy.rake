namespace :deploy do
  desc 'Stop Puma server.'
  task :stop do
    on roles(:app) do
      execute "cd #{DEPLOY_TO_DIR}/current && pkill -f puma"
    end
  end

  desc 'Start Puma server.'
  task :start do
    on roles(:app) do
      execute "cd #{DEPLOY_TO_DIR}/current && source ~/.bash_profile && bundle exec puma -e #{DEPLOY_ENV} -C config/puma.rb"
    end
  end
end