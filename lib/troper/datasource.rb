module Troper
  class DataSource
    attr_accessor :model, :name, :description, :joins
    attr_reader :liquid_attributes

    extend Forwardable
    def_delegators :@model, :table_name, :find, :columns

    def initialize(model, liquid_attributes)
      @model = model
      @liquid_attributes = liquid_attributes
    end

    def join(what)
      (self.joins ||= []).push what
    end

    def find(options)
      @model.all({:include => self.joins}.merge(options))
    end
  end
end
