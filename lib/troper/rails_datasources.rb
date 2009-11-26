module Troper
  class << self 
    # this method will bring all models from project uses

    def rails_default_datasources
      self.models.collect do |model|
        if model.kind_of?ActiveRecord::Base and model.respond_to? "to_liquid" # not model.instance_method_already_implemented? "to_liquid"
          attrs = (model.columns.collect{|c|c.name.to_sym} + model.reflections.keys) 
           
          model.class_eval { 
            liquid_methods *attrs
            define_method :liquid_attributes do
              attrs
            end
          }
        end
        Troper::DataSource.new(model, attrs)
      end
    end

    def dir_models
      File.join(Rails.root, "app", "models") 
    end

    def models
      Dir[File.join(dir_models, "*.rb")].collect do |file|
        model = file.gsub(/.rb$/,'').split("/").last.camelize
        model = model.camelize.constantize
        if model < ActiveRecord::Base # && model.table_exists?))# rescue nil)
         model 
        end
      end.compact
    end
  end
end
