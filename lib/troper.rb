module Troper
  class << self

    # dir rails root should be where the project 
    attr_accessor :dir_rails_root
    attr_accessor :datasources

    def root
      File.dirname(__FILE__)
    end

    def lib
      File.join(self.root, "troper")
    end
    # helper to liquidify a template with attributes
    # Example: 
    #   Troper.liquidify("hello {{ name }}!!!", {'name' => "world"})
    #   => "hello world!!!"
    def liquidify(template, attrs)
      Liquid::Template.parse(template).render attrs
    end
  end
end

require 'forwardable'
require 'RedCloth'
require 'liquid'

require File.join(File.dirname(__FILE__), 'troper', "column")
require File.join(File.dirname(__FILE__), 'troper', "columns")
require File.join(File.dirname(__FILE__), 'troper', "template")
require File.join(File.dirname(__FILE__), 'troper', "report")
require File.join(File.dirname(__FILE__), 'troper', "datasource")
require File.join(File.dirname(__FILE__), 'troper', "formatters")
require File.join(File.dirname(__FILE__), 'troper', "rails_datasources")
require File.join(File.dirname(__FILE__), 'troper', "routing")
require File.join(File.dirname(__FILE__), 'troper', "commands")

path = File.join(File.dirname(__FILE__), 'app', 'controllers')  
$LOAD_PATH << path 
ActiveSupport::Dependencies.load_paths << path 
ActiveSupport::Dependencies.load_once_paths.delete(path) 


require File.join(File.dirname(__FILE__), 'config', 'routes')

Troper.dir_rails_root = Rails.root
Troper.datasources = Troper.rails_default_datasources

Liquid::Template.register_filter(Troper::Formatters)
