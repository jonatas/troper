module Troper
  class DataSource
    attr_accessor :model, :name, :description, :joins

    extend Forwardable
    def_delegators :@model, :table_name, :find, :columns

    def initialize(model)
      @model = model
    end

    def join(what)
      (self.joins ||= []).push what
    end

    def find(options)
      @model.all({:include => self.joins}.merge(options))
    end
  end
end
