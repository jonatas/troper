desc "Gera o relatorio mensal de acompanhamento do estágio"
task :acompanhamento do 
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

  arquivo = "relatorio_acompanhamento" 

  if ENV['mes']
    @tarefas = @tarefas.select{|t|t['data'][3,2] == ENV['mes']}
    arquivo << "_mes_#{ENV['mes']}" 
  end

  if @tarefas.empty?
    puts 'não encontrou nenhuma tarefa.' 
    exit 
  end

  total_horas = @tarefas.inject(0) do |sum, tarefa|
    sum += $1.to_i if tarefa['tempo'] =~ /(\d+) horas/ 
    sum
  end

  File.open("#{arquivo}.html", "w+") do |file|
    file << Troper.liquidify(
             IO.read("docs/acompanhamento.html"),
             "tarefas" => @tarefas,
             "mes" => ENV['mes'],
             "data" => Date.today,
             "total_horas" => total_horas)
  end
  puts "gerou: #{arquivo}.html"

end
