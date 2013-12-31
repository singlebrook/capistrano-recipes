namespace :bower do
  desc "Install Bower front-end package management tool"

  task :install, :roles => :app do
    sudo 'npm install -g bower'
  end

  after 'deploy:install', 'bower:install'
end