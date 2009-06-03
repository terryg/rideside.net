# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "rideside.net"
set :repository, "http://tgl.textdrive.com/svn/#{application}/trunk"

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.

role :web, "burnaby.textdrive.com"
role :app, "burnaby.textdrive.com"
role :db,  "burnaby.textdrive.com", :primary => true

# =============================================================================
# OPTIONAL VARIABLES
# =============================================================================
set :deploy_to, "/home/tgl/domains/rideside.net/web" # defaults to "/u/apps/#{application}"
# set :user, "flippy"            # defaults to the currently logged in user
# set :scm, :darcs               # defaults to :subversion
# set :svn, "/path/to/svn"       # defaults to searching the PATH
# set :darcs, "/path/to/darcs"   # defaults to searching the PATH
# set :cvs, "/path/to/cvs"       # defaults to searching the PATH
# set :gateway, "gate.host.com"  # default to no gateway
set :checkout, "export"
set :use_sudo, false
set :user, "tgl"

# =============================================================================
# SSH OPTIONS
# =============================================================================
#ssh_options[:keys] = %w(/Users/tgl/.ssh/id_rsa.pub)
# ssh_options[:port] = 25

# =============================================================================
# TASKS
# =============================================================================
# Define tasks that run on all (or only some) of the machines. You can specify
# a role (or set of roles) that each task should be executed on. You can also
# narrow the set of servers to a subset of a role by specifying options, which
# must match the options given for the servers to select (like :primary => true)

after 'deploy:setup', 'drupal:setup'

before 'deploy:restart', 'rideside:permissions:fix', 'rideside:symlink:application'

namespace :drupal do
  task :setup, :exception => { :no_release => true } do
    run "chown -R #{user}:#{user} #{deploy_to}"
  end
end

namespace :deploy do
  task :finalize_update, :except => { :no_release => true } do
    run "chmod =R g+w #{latest_release}" if fetch(:group_writable, true)
  end

  task :restart do
    # do nothing, we're on mod-php
  end
end

namespace :rideside do
  namespace :symlink do
    task :application, :except => { :no_release => true } do
      run "rm -r #{release_path}/files"
      run "ln -nfs #{shared_path}/files #{release_path}/files" 
    end
  end

  namespace :permissions do
    task :fix, :except => { :no_release => true } do

    end
  end
end

