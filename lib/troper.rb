#require "~/projetos/rails/agecel/config/environment.rb"
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

require 'rubygems'
require 'forwardable'
require 'liquid'

require File.join(File.dirname(__FILE__), 'troper', "column.rb")
require File.join(File.dirname(__FILE__), 'troper', "columns.rb")
require File.join(File.dirname(__FILE__), 'troper', "template.rb")
require File.join(File.dirname(__FILE__), 'troper', "report.rb")
require File.join(File.dirname(__FILE__), 'troper', "datasource.rb")
require File.join(File.dirname(__FILE__), 'troper', "formatters.rb")
require File.join(File.dirname(__FILE__), 'troper', "rails_datasources.rb")
require File.join(File.dirname(__FILE__), 'init.rb')

