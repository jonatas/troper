module Troper
  class << self 
    # this method will bring all models from project uses

    def rails_default_datasources
      self.models.collect do |model|
        # liquidifying attributes 
        if not model.instance_method_already_implemented? "to_liquid"
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
        model.camelize.constantize
      end
    end
  end
end
