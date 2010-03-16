set :application, "figment"

default_run_options[:pty] = true
ssh_options[:port] = '8887'
set :user, "wotsrovert"
set :remote_machine, "74.208.173.137"

set :scm, :git
set :repository, "ssh://74.208.173.137:8887/usr/local/git-repo/figment.git"
set :deploy_to, "/var/apps/#{application}"

set :branch, ( if ENV["BRANCH"]
    ENV["BRANCH"]
else
    "master"
end)


role :app, "#{remote_machine}"
role :web, "#{remote_machine}"
role :db,  "#{remote_machine}", :primary => true


namespace :deploy do
    task :start do ; end
    task :stop do ; end
    task :restart, :roles => :app, :except => { :no_release => true } do
        run "touch #{File.join(current_path,'tmp','restart.txt')}"
    end

    desc "auto migrate"
    task :migrate do
        run "cd #{current_path};RAILS_ENV=production rake db:auto:migrate"
    end

    after 'deploy:update_code' do
        symlink
    	symlink_to_database_yml		
	    migrate
    end
    
    desc "Link to each database.yaml in shared/config"
	task :symlink_to_database_yml do
		run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    end
    
end

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
