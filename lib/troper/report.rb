module Troper


  class Report
    extend Forwardable
    def_delegators :@datasource, :table_name, :find, :model
    def_delegators :@template, :template_to_resource, :header, :body, :footer

    attr_accessor :datasource, :columns, :data, :filters, :template
    

    def initialize(table_name)
      self.datasource = Troper.datasources.find{|datasource|datasource.model.table_name == table_name}

      self.columns = []
      self.columns.extend Troper::Columns
      self.filters = []

      self.model.columns.each do |column|
        next if column.primary or column.name =~ /(_id|_count)$|(created|updated)_at$/
        column = Troper::Column.new column, datasource 
        @columns.add column
      end

      if not model.instance_method_already_implemented? "to_liquid"
        model.class_eval do 
        alias_method :to_liquid, :attributes
        end 
      end
      self.template = Troper::Template.new(self)
    end

    def columns_title
      self.columns.collect{|c|c.label}
    end

    def collection_name
      table_name
    end

    def record_name
      model.to_s.downcase
    end

    def output 
      template.render hasheize_data
    end

    def hasheize_data
     hashes = 
       if self.data and self.data.respond_to? "hashes"
         self.data.hashes
       else
         self.data = model.find(:all) #.collect{|e|e.attributes}
       end
       {table_name => hashes}
    end
  end
end
