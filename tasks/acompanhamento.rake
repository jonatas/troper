def tarefas
  File.readlines("acompanhamento.textile").each do |linha|
    if linha =~ /^\* (\d{2}\/\d{2}\/\d{4}) - \[ (.*) \] - (.*)$/
      if @tarefa
        (@tarefas ||= []).push @tarefa
      end
    @tarefa = {
               'data' => $1, 
               'tempo' => $3,
               'envolvidos' => $2.split(", "),
               'atividades' => []
    }
    else
      @tarefa['atividades'] << linha
    end
  end

  if ENV['mes']
    @tarefas = @tarefas.select{|t|t['data'][3,2] == ENV['mes']}
  end

  if @tarefas.empty?
    puts 'não encontrou nenhuma tarefa.' 
    raise ''
  end
  @tarefas
end

def gerar_relatorio opcoes = {} 
  total_horas = @tarefas.inject(0) do |sum, tarefa|
    sum += $1.to_i if tarefa['tempo'] =~ /(\d+) horas/ 
    sum
  end

  File.open("#{opcoes[:nome_arquivo]}.html", "w+") do |file|
    file << Troper.liquidify(
      IO.read("docs/#{opcoes[:template]}.html"),
             "tarefas" => @tarefas,
             "mes" => ENV['mes'],
             "data" => Date.today,
             "total_horas" => total_horas)
  end
  puts "gerou: #{opcoes[:nome_arquivo]}.html"
end

desc "Gera o Relatório Mensal de Atividades do Estágio na Empresa" 
task :mensal_empresa do 
  tarefas
  arquivo = "relatorio_atividades_empresa_mes_#{ENV['mes']}" 

  @tarefas.delete_if { |tarefa| tarefa['envolvidos'].include? "almir" }

  gerar_relatorio(:template => "mensal_empresa", :nome_arquivo => arquivo)
end

desc "Gera o Relatório Mensal de Acompanhamento do Orientador" 
task :acompanhamento do 
  tarefas
  arquivo = "relatorio_acompanhamento"
  arquivo << "_mes_#{ENV['mes']}" if ENV['mes']
  @tarefas = @tarefas.select { |tarefa| tarefa['envolvidos'].include? "almir" }

  gerar_relatorio(:template => "acompanhamento", :nome_arquivo => arquivo)
end


