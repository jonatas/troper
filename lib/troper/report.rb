module Troper
  class Report
    extend Forwardable
    def_delegators :@datasource, :table_name, :find, :model

    attr_accessor :datasource, :columns, :data
    def initialize(table_name)
      @datasource = Troper.datasources.find{|datasource|datasource.model.table_name == table_name}

      @columns = []
      @columns.extend Troper::Columns

      self.model.columns.each do |column|
        next if column.primary or column.name =~ /(_id|_count)$|(created|updated)_at$/
        column = Troper::Column.new column, datasource 
        @columns.add column
      end

    end

    def columns_title
      @columns.collect{|c|c.label}
    end

    def collection_name
      table_name
    end

    def record_name
      model.to_s.downcase
    end

    def template_to_resource
%(<table id="#{table_name}">
    <th>
      <td>#{columns_title.join("</td><td>")}</td>
   </th>

   {% for #{record_name} in #{collection_name} %}
   <tr>
     <td>#{@columns.collect{|c|c.template_to_resource}.join("</td><td>")}</td>
   </tr>
   {% endfor %}      
</table>)
    end
    def output
       grid 
    end
    def grid 
      Troper.liquidify(template_to_resource, hasheize_data)
    end

    def hasheize_data
     {table_name => @data.hashes}
    end

    

    
  end
end
