namespace :passenger do
  desc "Set up Passenger for use with Apache"
  task :install, :roles => :app do
    apt_install 'libcurl4-openssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev'
    sudo 'gem install passenger'
    sudo 'passenger-install-apache2-module --auto'
    sudo 'passenger-install-apache2-module --snippet > /tmp/passenger.load'
    sudo 'mv /tmp/passenger.load /etc/apache2/mods-available/passenger.load'
    put_as_root passenger_conf, '/etc/apache2/mods-available/passenger.conf'
    sudo 'a2enmod passenger'
    sudo 'service apache2 restart'
  end
  after "deploy:install", "passenger:install"
end


def passenger_conf
<<-EOF
# Always keep instance one of each app running
PassengerMinInstances 1
# Don't shut idle instances down
PassengerPoolIdleTime 0
# WARNING: This can break other Apache modules
PassengerHighPerformance on
EOF
end