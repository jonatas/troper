require 'rails_generator'
require 'rails_generator/commands'
require "FileUtils" unless defined?(FileUtils)

include FileUtils::Verbose

module Troper
  module Generator #:nodoc:  
    module Commands #:nodoc:  
      module Create 
        def troper_route
          logger.route "map.datasources" 
          look_for = 'ActionController::Routing::Routes.draw do |map|' 
          unless options[:pretend] 
            gsub_file('config/routes.rb', /(#{Regexp.escape(look_for)})/mi){|match| "#{match}\n  map.datasources\n"} 
          end
        end 
        def troper_html
          FileUtils.cp File.join(Troper.root, '..', 'public', 'troper.html'), File.join(Rails.root, 'public')
        end
      end  
      module Destroy 
        def troper_route 
          logger.route "map.datasources"  
          gsub_file 'config/routes.rb', /\n.+?map\.datasources/mi, ''  
        end
        def troper_html
          FileUtils.rm_f File.join(Rails.root, '..', 'public','troper.html')
        end
      end 
      module List 
        def troper_route 
        end  
      end 
      module Update 
        def troper_route 
        end  
      end 
    end  
  end 
end 

Rails::Generator::Commands::Create.send :include, Troper::Generator::Commands::Create
Rails::Generator::Commands::Destroy.send :include, Troper::Generator::Commands::Destroy
Rails::Generator::Commands::List.send  :include, Troper::Generator::Commands::List 
Rails::Generator::Commands::Update.send  :include, Troper::Generator::Commands::Update 
