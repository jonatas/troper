Given /^that I am able to see a (\w+) table$/ do |table|
  @report = Troper::Report.new(table) 
  @report.model.table_name.should == table
end

When /^I am looking for columns of this report$/ do
  @columns = @report.columns
end

Then /^should be equal: (.*)$/ do |names|
  @columns.collect{|e|e.name}.should == names.split(", ")
end

When /^I am looking for column '(\w+)'$/ do |name|
  @column = @columns[name]
end

Then /^the (.*) should be equal '(.*)'$/ do |method, expected|
  method.gsub!(/ /,'_')

  @result = @column.send(method) if not method == "result"
  @result.should == expected
end

Given /^that I override this resource to format with (.*)$/ do |format|
  @column.formats << format
end

Given /^that I bind it for template with (\w+) '(.*)'$/ do |column_name, value|
  @result = @columns[column_name].bind_value( value )
end

Given /^that I am able to see a template for this report$/ do |string|
  @result = @report.template_to_resource 
end

Given /^the folowing data for this table$/ do |table|
  @report.data = table
end

When /^I am looking for output$/ do
  @result = @report.output
end

Then /^will get a string builded on template$/ do
  @result.should be_kind_of(String)
end

When /^I put a new filter to get only people with phone$/ do
  @report.filters << "person.phone"
  @report.filters << "person.email"
end

Given /^that I will join many address for each person$/ do
  @report.columns.add "addresses"
end
 
Then /^I will see "([^\"]*)" on the template to resource$/ do |arg1|
  @report.template_to_resource.should include(arg1)
end

Given /^that I put a manual template to resource like$/ do |string|
  @report.manual_template_to_resource = string
end

Then /^I will see "([^\"]*)"\{% for person in people %\} \{\{person\.name \| truncate: 10 \}\} \\n \{% endfor %\}" on the template to resource$/ do |arg1|
  @report.template_to_resource.should include(arg1)
end



