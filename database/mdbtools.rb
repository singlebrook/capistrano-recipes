namespace :mdbtools do
  desc "install mdbtools and libmdb for accessing Access databases"
  task :install do
    apt_install 'mdbtools libmdb2'
  end
end
