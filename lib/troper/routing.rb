module Troper
  module Routing
    module MapperExtensions
      def datasources
        @set.add_route("/datasources", {:controller=> "datasources", :action => "index"})
      end
    end
  end
end
ActionController::Routing::RouteSet::Mapper.send :include, Troper::Routing::MapperExtensions 
