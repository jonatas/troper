
module Troper
  class Report
    extend Forwardable
    def_delegators :@datasource, :table_name, :find, :model

    attr_accessor :datasource, :columns
    def initialize(table_name)
      if table_name.kind_of?String
        @datasource = Troper.datasources.find{|datasource|datasource.model.table_name == table_name}
      end

      @columns = self.model.columns.reject{ |c| c.primary or c.name =~ /(_id|_count)$|(created|updated)_at$/ }
    end

    
  end
end

