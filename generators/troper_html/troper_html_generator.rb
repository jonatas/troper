class TroperHtmlGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.troper_html
    end  
  end 
end 
