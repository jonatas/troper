desc "Gera as documentações html dentro da pasta website"
task :docs do 
  Dir["docs/*.txt"].each do |file|
    `script/txt2html #{file} > #{file.gsub(/\.txt$/, '.html')}`  
  end
end
