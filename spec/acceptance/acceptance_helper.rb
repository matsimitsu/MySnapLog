require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'

include Capybara 

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
