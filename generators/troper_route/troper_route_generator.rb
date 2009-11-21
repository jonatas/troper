class TroperRouteGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.troper_route 
    end  
  end 
end 
