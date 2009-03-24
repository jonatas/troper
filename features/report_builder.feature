Feature: Manage reports using simple steps to build. 
  Scenario: Create a simple report using a table as datasource.
    Given that I'm able to see a people table

    When I'm looking form columns for this report
      Then the default should be able to see all columns from table
      And should be equal: name, email, phone

      When I'm looking for column 'name'
        Then the label should be equal 'Name'
        And the resource should be equal 'person.name'
        And the template from resource should be equal '{{ person.name }}'

      When I'm looking for column 'email'
        Given that I override this resource to format with link_to_mail
        Then the template from resource should be equal '{{ person.email | link_to_mail }}'
        Given that I bind it for template with mail 'jonatasdp@gmail.com'
        Then the resuld should be equal '<a mailto:jonatasdp@gmail.com>jonatasdp@gmail.com</a>' 

      When I'm looking for column 'phone'
        Given that I override this resource to format with format_phone_number
        Then the template from resource should be equal '{{ person.phone | format_phone_number }}'
        Given that I bind it for template with phone '4699117879'
        Then the resuld should be equal '(46) 9911-7879'

    When I'm looking for datagrid
      Given the folowing data for this table
      | name         | mail                | phone      |
      | jonatas davi | jonatasdp@gmail.com | 4699117879 |
      | peter pan    | peter@pan.net       | 4567890222 |
      
      

