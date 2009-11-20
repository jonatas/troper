Funcionalidade: Gerenciar relatorios usando simples passos para construi-lo.
  Cenário: Criar um relatório simples usando uma tabela como fonte de dados
     Dado que posso ver a tabela pessoas como relatório
     Quando olhar para as colunas desse relatório
     Então deve ser igual: nome, email, telefone

     Quando eu olhar para a coluna 'nome'
       Então o titulo deve ser igual a 'Nome'
       E o recurso deve ser igual a 'pessoa.nome'
       E a template para este recurso deve ser igual a '{{ pessoa.nome }}'

     Quando eu olhar para a coluna 'email'
       Dado que eu sobrescrevo este recurso para formatar com link_para_email
       Então a template para o recurso deve ser igual a '{{ pessoa.email | link_para_email }}'

     Quando eu olhar para a coluna 'telefone'
       Dado que eu sobrescrevo este recurso para formatar com formatar_como_numero_de_telefone
       Então a template para o recurso deve ser igual a '{{ pessoa.email | formatar_como_numero_de_telefone }}'

    Dado a seguinte template para o reltório 
    """
<table id="pessoas">
  <th>
    <td>Nome</td><td>Email</td><td>Telefone</td>
  </th>
  
  {% for pessoa in pessoas %}
      <tr>
        <td>{{ pessoa.nome }}</td>
        <td>{{ pessoa.email | link_para_email }}</td>
        <td>{{ pessoa.telefone | formatar_como_numero_de_telefone}}</td>
      </tr>
  {% endfor %}      
</table>
    """

   Dado os seguintes dados para essa tabela
      | nome         | email               | telefone   |
      | jonatas davi | jonatasdp@gmail.com | 4699117879 |
      | peter pan    | peter@pan.net       | 4567890222 |
      | steven dot   | steve@dotn.org      |            |

   Quando eu olhar a saída de dados
   Então deve conter todos registros
   Então devo ver uma string construída sobre a template
   
   Quando eu adicionar um filtro para pegar apenas pessoas com telefone
   Quando eu olhar a saída de dados
   Então não deve conter todos registros

   Quando eu adicionar vários endereços para cada pessoa
   Quando eu olhar a saída de dados
   Então deve montar uma expressão com os endereços usando declaração for endereco in pessoa.enderecos
