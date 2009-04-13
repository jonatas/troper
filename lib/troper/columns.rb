module Troper
  # this module should represent the columns collection 
  module Columns
    def find_by_names(*names)
      self.find_all { |column| names.include? column.name }
    end

    def find_by_name(name)
      self.find { |c| c.name == name }
    end
    alias_method :[], :find_by_name


    def add(column)
      self.push column if not find_by_name(column.name)
    end

    alias_method :<<, :add

    def build_values(columns)
      case columns.class
      when Array
        self.each_with_index do |column, index|
          column.value = columns[index]
        end
      when ActiveRecord::Base, Hash
        self.columns.each do |column|
          column.value = columns[column.name]
        end
      end
    end

  end
end
       

