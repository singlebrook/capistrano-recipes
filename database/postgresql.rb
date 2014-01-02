# -*- encoding : utf-8 -*-
# set_default(:postgresql_host, "localhost")
# set_default(:postgresql_user) { application }
# set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
# set_default(:postgresql_database) { "#{application}_production" }

namespace :postgresql do
  desc "install the latest stable release of PostgreSQL and client libraries."
  task :install do
    # Set up per https://wiki.postgresql.org/wiki/Apt
    sudo 'wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -'
    put_as_root "deb http://apt.postgresql.org/pub/repos/apt/ #{ubuntu_release_codename}-pgdg main", '/etc/apt/sources.list.d/pgdg.list'
    sudo 'apt-get -qq update'
    apt_install 'postgresql', :roles => :db
    apt_install 'libpq-dev' # All servers need to be able to compile against this

    # Change the encoding of the template1 database to UTF8
    run %q(sudo -u postgres psql -c "update pg_database set datallowconn = TRUE where datname = 'template0';")
    run %q(sudo -u postgres psql -c "update pg_database set datistemplate = FALSE where datname = 'template1';")
    run %q(sudo -u postgres psql -c "drop database template1;")
    run %q(sudo -u postgres psql -c "create database template1 with template = template0 encoding = 'UTF8' LC_CTYPE = 'en_US.utf8' LC_COLLATE = 'en_US.utf8';")
    run %q(sudo -u postgres psql -c "update pg_database set datistemplate = TRUE where datname = 'template1';")
    run %q(sudo -u postgres psql -c "update pg_database set datallowconn = FALSE where datname = 'template0';")
  end
  after "deploy:install", "postgresql:install"

  # desc "Create a database for this application"
  # task :create_database, :roles => :db, :only => {:primary => true} do
  #   run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
  #   run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  # end
  # after "deploy:setup", "postgresql:create_database"

  # desc "Generate the database.yml config file"
  # task :setup, :roles => :app do
  #   run "mkdir -p #{shared_path}/config"
  #   template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
  # end
  # after "deploy:setup", "postgresql:setup"

  # desc "Symlink the database.yml file into latest release"
  # task :symlink, :roles => :app do
  #   run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  # end
  # after "deploy:finalize_update", "postgresql:symlink"
end
