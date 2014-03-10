namespace :redis do
  desc "Set up Redis key-value store"
  task :install, :roles => :app do
    apt_install 'redis-server'
  end
  after "deploy:install", "redis:install"
end
