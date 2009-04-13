Feature: Manage reports using simple steps to build. 
  In order to create a simple report using table
  As a simple user 
  I want to create a simple report using the options default.

  Scenario: Create a simple report using a table as datasource:
    Given that I am able to see a people table

    When I am looking form columns for this report
      And should be equal: name, email, phone

      When I am looking for column 'name'
        Then the label should be equal 'Name'
        And the resource should be equal 'person.name'
        And the template to resource should be equal '{{ person.name }}'

      When I am looking for column 'email'
        Given that I override this resource to format with link_to_mail
        Then the template to resource should be equal '{{ person.email | link_to_mail }}'
        Given that I bind it for template with email 'jonatasdp@gmail.com'
        Then the result should be equal '<a href='mailto:jonatasdp@gmail.com'>jonatasdp@gmail.com</a>' 

      When I am looking for column 'phone'
        Given that I override this resource to format with format_phone_number
        Then the template to resource should be equal '{{ person.phone | format_phone_number }}'
        Given that I bind it for template with phone '4699117879'
        Then the result should be equal '(46) 9911-7879'



    Given that I am able to see a template for this report
    """
<table id="people">
  <th>
    <td>Name</td><td>Email</td><td>Phone</td>
  </th>
  
  {% for person in people %}
      <tr>
        <td>{{ person.name }}</td><td>{{ person.email | link_to_mail }}</td><td>{{ person.phone | format_phone_number }}</td>
      </tr>
  {% endfor %}      
</table>
    """

   Given the folowing data for this table
      | name         | email               | phone      |
      | jonatas davi | jonatasdp@gmail.com | 4699117879 |
      | peter pan    | peter@pan.net       | 4567890222 |
      | steven dot   | steve@dotn.org      |            |

   When I am looking for output
   Then will get a string builded on template
      

