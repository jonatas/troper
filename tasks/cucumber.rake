begin
  gem 'cucumber'
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty"
  end
  Cucumber::Rake::Task.new('features:html') do |t|
    t.cucumber_opts = "--format html --out funcionalidades.html --language pt"
  end
rescue LoadError
  puts "Erro tentando rodar as features",$!,"-"*50,$@
end
