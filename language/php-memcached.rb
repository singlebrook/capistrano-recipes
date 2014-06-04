# -*- encoding : utf-8 -*-
namespace :php_memcached do
  desc "Install PHP 5.3 memcached integration"
  task :install, :roles => :app do
    apt_install 'php5-memcached'
  end
  after "deploy:install", "php_memcached:install"
end
