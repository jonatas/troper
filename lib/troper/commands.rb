require 'rails_generator'
require 'rails_generator/commands'
module Troper
  module Generator #:nodoc:  
    module Commands #:nodoc:  
      module Create 
        def troper_routes
          logger.route "map.datasources" 
          look_for = 'ActionController::Routing::Routes.draw do |map|' 
          unless options[:pretend] 
            gsub_file('config/routes.rb', /(#{Regexp.escape(look_for)})/mi){|match| "#{match}\n  map.datasources\n"} 
          end
        end 
      end  
      module Destroy 
        def troper_routes 
          logger.route "map.datasources"  
          gsub_file 'config/routes.rb', /\n.+?map\.datasources/mi, ''  
        end
      end 
      module List 
        def troper_routes 
        end  
      end 
      module Update 
        def troper_routes 
        end  
      end 
    end  
  end 
end 

Rails::Generator::Commands::Create.send :include, Troper::Generator::Commands::Create
Rails::Generator::Commands::Destroy.send :include, Troper::Generator::Commands::Destroy
Rails::Generator::Commands::List.send  :include, Troper::Generator::Commands::List 
Rails::Generator::Commands::Update.send  :include, Troper::Generator::Commands::Update 
