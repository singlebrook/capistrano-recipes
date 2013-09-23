# -*- encoding : utf-8 -*-
namespace :ufw do
  desc "Install firewall from package manager"
  task :install do
    sudo 'ufw allow ssh'
    sudo 'ufw --force enable'

    sudo 'ufw allow http', :roles => :web, :on_no_matching_servers =>
:continue
    sudo 'ufw allow https', :roles => :web, :on_no_matching_servers =>
:continue
  end
  after 'deploy:install', 'ufw:install'
end
