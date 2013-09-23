namespace :postfix do
  desc "Install postfix MTA"
  task :install do
    apt_install 'postfix'
  end
  after "deploy:install", "postfix:install"
end
