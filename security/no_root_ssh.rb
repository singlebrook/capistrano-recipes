# -*- encoding : utf-8 -*-
namespace :no_root_ssh do
  desc "Disable ssh connections as root user"
  task :install do
    sudo "perl -pi -e 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config"
  end
  after 'deploy:install', 'no_root_ssh:install'
end
