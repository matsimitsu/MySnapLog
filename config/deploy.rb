set :application, 'mysnaplog'

set :scm, :git
set :repository, "."
set :branch, 'master'
set :git_enable_submodules, true
set :deploy_via, :copy
set :copy_strategy, :export
set :use_sudo, true

ssh_options[:forward_agent] = true
ssh_options[:username] = 'robertbeekman'

role :app, 'nzbtv.com'
role :web, 'nzbtv.com'
role :db,  'nzbtv.com', :primary => true

set :deploy_to, "/Sites/#{application}/app"
before  "deploy:finalize_update", "worker:stop"
after   "deploy:finalize_update", "worker:start"
after 'deploy:update_code', 'deploy:bundle'

task :tail do
  run "tail -f #{deploy_to}/shared/log/production.log"
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :finalize_update, :roles => :app do
    run "ln -s #{deploy_to}/shared/log #{release_path}/log"
    run "ln -s #{deploy_to}/shared/tmp #{release_path}/tmp" 
    run "ln -s #{deploy_to}/shared/system #{release_path}/public/system"
  end
  
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Install bundled gems into ./.bundle"
  task :bundle do
    run "cd #{release_path}; bundle install .bundle"
  end
end

namespace :worker do
  task :start, :roles => :app do
    run "god -c #{current_path}/config/navvy.god start"
  end
  
  task :stop, :roles => :app do
    run "god -c #{current_path}/config/navvy.god stop"
  end
end



