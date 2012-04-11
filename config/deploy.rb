# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user  # Don't use system-wide RVM
require "bundler/capistrano"
set :application, "NewBethanyMinistry"
set :repository,  "git@github.com:chickensen/New-Bethany-Ministry-Project.git"

set :scm, "git"
set :user, "newbethany"
set :scm_passphrase, "NBM2001a"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "50.63.147.117"                          # Your HTTP server, Apache/etc
role :app, "50.63.147.117"                          # This may be the same as your `Web` server
role :db,  "50.63.147.117", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end