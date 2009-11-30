module Troper
  class Column

    attr_accessor :name, :formats, :stack
    attr_writer :label

    def initialize name, stack
      self.name = name 
      self.formats = []
      self.stack = stack
    end

    def resource
      [stack, name].join(".")
    end

    def label
      @label || name.humanize
    end
    
    def template_to_resource
      "{{ " + resources.join(" | ") + " }}"
    end

    def resources
      [resource] + formats
    end

  end
end
