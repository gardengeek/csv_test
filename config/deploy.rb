require "bundler/capistrano"
require File.join(File.dirname(__FILE__),"initializers","baseline.rb")

set :application, ::Baseline::AppName.downcase
set :repository,  "set your repository location here"

set :scm, :git
set :git_enable_submodules, 1
set :deploy_via, :remote_cache

set :user, application
set :use_sudo, false
set :deploy_to, "/home/#{application}"

set :bundle_dir,      ""
set :bundle_flags,    "--quiet"

server ::Baseline::DefaultHost, :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
