require File.join(File.dirname(__FILE__), "..","..","lib","rails_example", "config", "environment")
require File.join(File.dirname(__FILE__), "..","..","lib","troper")
require 'spec' 
require 'mocha'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
