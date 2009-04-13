require File.join(File.dirname(__FILE__), "..","..","lib","troper.rb")
require 'spec' 
require 'mocha'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
