module Troper
  class << self 
    # this method will bring all models from project uses

    def rails_default_data_sources
      self.models.collect do |model|
        # liquidifying attributes 
        if not model.instance_method_already_implemented? "to_liquid"
          model.class_eval { liquid_methods *(model.columns.collect{|c|c.name.to_sym} + model.reflections.keys) }
        end
        Troper::DataSource.new(model)
      end
    end

    def dir_models
      File.join(Troper.dir_rails_root, "app", "models") 
    end

    def models
      Dir[File.join(dir_models, "*.rb")].collect do |file|
        model = file.gsub(/.rb$/,'').split("/").last.camelize
        model.camelize.constantize
      end
    end
  end
end
