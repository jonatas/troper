Feature: Manage reports using simple steps to build. 
  Scenario: Create a simple report using a table as datasource.
     Given that I am able to see a people table
     When I am looking for columns of this report
     And should be equal: name, email, phone

      When I am looking for column 'name'
        Then the label should be equal 'Name'
        And the resource should be equal 'person.name'
        And the template to resource should be equal '{{ person.name }}'

      When I am looking for column 'email'
        Given that I override this resource to format with link_to_mail
        Then the template to resource should be equal '{{ person.email | link_to_mail }}'

      When I am looking for column 'phone'
        Given that I override this resource to format with format_phone_number
        Then the template to resource should be equal '{{ person.phone | format_phone_number }}'

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
   
   When I put a new filter to get only people with phone
   Then I will see "if person.phone" on the template to resource

   Given that I will join many address for each person
   Then I will see "{% for address in person.addresses %}" on the template to resource
  
   Given that I put a manual template to resource like 
    """
{% for person in people %} {{person.name | truncate: 10 }} \\n {% endfor %}
    """

   Then I will see ""{% for person in people %} {{person.name | truncate: 10 }} \n {% endfor %}" on the template to resource 

      
