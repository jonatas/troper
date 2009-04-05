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
  end
end

require File.join(Troper.lib, "report.rb")
require File.join(Troper.lib, "datasource.rb")
require File.join(Troper.lib, "rails_datasources.rb")

require File.join(Troper.root, "init.rb")

