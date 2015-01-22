namespace :apache2_passenger_vhost do
  desc "Create a Passenger-ready apache2 vhost for [application]"
  task :install do
    put_as_root read_template('apache2_passenger_vhost.erb'), "/etc/apache2/sites-available/#{application}.conf"
    sudo "a2ensite #{application}"
    sudo "service apache2 restart"
  end
  after 'deploy:install', 'apache2_passenger_vhost:install'
end
