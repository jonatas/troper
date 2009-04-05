
Given /^that I am able to see a (\w+) table$/ do |table|
  @report = Troper::Report.new(table) 
  @report.model.table_name.should == table
end

When /^I am looking form columns for this report$/ do
  @columns = @report.columns
end

Then /^should be equal: (.*)$/ do |names|
  @columns.collect{|e|e.name}.should == names.split(", ")
end

When /^I am looking for column 'name'$/ do
end

Then /^the label should be equal 'Name'$/ do
end

Then /^the resource should be equal 'person\.name'$/ do
end

Then /^the template from resource should be equal '\{\{ person\.name \}\}'$/ do
end

When /^I am looking for column 'email'$/ do
end

Given /^that I override this resource to format with link_to_mail$/ do
end

Then /^the template from resource should be equal '\{\{ person\.email \| link_to_mail \}\}'$/ do
end

Given /^that I bind it for template with mail 'jonatasdp@gmail\.com'$/ do
end

Then /^the resuld should be equal '<a mailto:jonatasdp@gmail\.com>jonatasdp@gmail\.com<\/a>'$/ do
end

When /^I am looking for column 'phone'$/ do
end

Given /^that I override this resource to format with format_phone_number$/ do
end

Then /^the template from resource should be equal '\{\{ person\.phone \| format_phone_number \}\}'$/ do
end

Given /^that I bind it for template with phone '4699117879'$/ do
end

Then /^the resuld should be equal '\(46\) 9911\-7879'$/ do
end

When /^I am looking for datagrid$/ do
end

Given /^the folowing data for this table$/ do |table|
  puts table
end
