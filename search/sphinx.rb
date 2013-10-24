namespace :sphinx do
  desc "Set up Sphinx"
  task :install, :roles => :app do
    apt_install 'sphinxsearch'
  end
  after "deploy:install", "sphinx:install"
end
