Troper.dir_rails_root =  defined?(Rails)? Rails.root : File.join(Troper.root , "rails_example")

require File.join(Troper.dir_rails_root, "config", "environment.rb")

Troper.datasources = Troper.rails_default_data_sources
