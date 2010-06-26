# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'
begin
  require 'navvy/tasks'
rescue LoadError
  namespace :navvy do
    abort "Couldn't find Navvy. " << 
      "Please run `gem install navvy` to use Navvy's tasks."
  end
end
