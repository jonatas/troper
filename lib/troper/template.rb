module Troper
  class Template
    extend Forwardable
    attr_accessor :report
    def_delegators :@report, :table_name,  :columns_title, 
                             :record_name, :collection_name,
                             :filters,     :columns, :model
    def initialize(report)
      self.report = report
    end

    def header
      %(<table id="#{table_name}">
          <tr>
             <td>#{columns_title.join("</td><td>")}</td>
          </tr>
          )
    end

    def body
      %({% for #{record_name} in #{collection_name} %}
      #{apply_filters do 
        %(<tr><td>#{columns.collect do |column|
          if association = model.reflections[column.name.to_sym] and
             association.macro.to_s =~ /has_many|has_and_belongs_to_many/
               Troper::Report.new(column.name, self.report).template_to_resource
          else
            column.template_to_resource
          end
        end.join("</td><td>")}</td></tr>)
      end}
      {% endfor %}) 
    end

    def apply_filters
      return yield if filters.empty?

      %({% if #{filters.join " and "} %}
         #{yield}
        {% endif %})
    end

    def footer
      %(</table>)
    end

    def template_to_resource
      report.manual_template_to_resource || ( header + body + footer )
    end

    def render(context)
      Troper.liquidify(template_to_resource, context)
    end
  end
end
