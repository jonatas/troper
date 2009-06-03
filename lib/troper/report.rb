module Troper


  class Report
    extend Forwardable
    def_delegators :@datasource, :table_name, :find, :model, :join
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

    # Array with a colums' label
    # Example:
    #   p Troper::Report.new("people").columns_title
    #   => ["Name", "Email", "Phone"]
    def columns_title
      self.columns.collect{|c|c.label}
    end
    
    # the same of table name  
    # Example:
    #    Troper::Report.new("people").collection_name 
    #    => "people"
    def collection_name
      table_name
    end

    # the same of model name
    # Example:
    #   Troper::Report.new("people").record_name    
    #   => "person"
    def record_name
      model.to_s.downcase
    end
    # generates the output render the template with the context
    #
    # Example:
    #   puts Troper::Report.new("people").output
    #   => <table id="people"><th><td>Name</td><td>Email</td><td>Phone</td></th>
    #       <tr><td>Jônatas Davi Paganini</td><td>jonatasdp@gmail.com</td><td>46 9911 7879</td></tr>
    #       <tr><td>Peter Pan</td><td>peter@pan.net</td><td>46 8822 8800</td></tr>
    #    </table>
    def output 
      template.render hasheize_data
    end

    # Converts data to hashes to use with liquid templates
    #
    # Example:
    #   Troper::Report.new("people").hasheize_data 
    #   => {"people"=>[#<Person id: 1, name: "Jônatas...
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
