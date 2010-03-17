# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

require 'fileutils'

namespace :update do
    namespace :local do
        desc "Copy down the production database"
        task :db do
            system("cp ./db/development.sqlite3 /tmp/#{application}.development.sqlite3.#{Time.now.strftime('%Y.%m.%d')} ")
            cmd = "scp #{ user }@#{ remote_machine }:#{deploy_to}/shared/db/production.sqlite3 ./db/development.sqlite3"

            puts cmd
            system(cmd)
        end
    end
end
