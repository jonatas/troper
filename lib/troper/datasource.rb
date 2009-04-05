module Troper
  class DataSource
    attr_accessor :model, :name, :description

    extend Forwardable
    def_delegators :@model, :table_name, :find, :columns

    def initialize(model)
      @model = model
    end
  end
end
