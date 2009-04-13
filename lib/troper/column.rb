module Troper
  class Column

    extend Forwardable

    def_delegators :@active_record_column, :name, :type, :human_name
    def_delegators :@datasource, :model
    def_delegators :model, :table_name

    attr_accessor :active_record_column, :datasource, :resource, :formats, :value

    def initialize(column, datasource)
      self.active_record_column = column
      self.datasource = datasource 
      self.formats = []
    end

    alias_method :label, :human_name

    def resource
      @resource ||= "#{datasource.model}.#{name}".downcase
    end

    def template_to_resource
      "{{ #{resources.join(" | ")} }}"
    end

    def resources
      [resource] + formats
    end

    def bind_value(value)
      record, attribute = resource.split(".")

      Troper.liquidify(template_to_resource, record => { attribute => value })
    end
  end
end
