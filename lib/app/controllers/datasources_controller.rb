class DatasourcesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    respond_to do |format|
      format.html # render static index.html.erb

      format.json { 

        if params[:node] == '0'
          render :json =>  Troper.datasources.collect{|m|{:text => m.model.to_s, :id => m.model.to_s, :parent_id => 0}}.to_json
        else 

          node = params[:node]
          if node =~ /(\w+)$/
            node = $1
          end
          datasource = Troper.datasources.find{|e|e.model.to_s.downcase == node.downcase }
          datasource ||= Troper.datasources.find{|e|e.model.to_s.downcase == node.singularize.downcase}

          attrs = datasource.liquid_attributes
          render :json => attrs.collect{|c|{"text"=>c, "leaf" => false, "id" => "#{datasource.model.to_s.downcase}.#{c}", "parent_id" => datasource.model.to_s}}.to_json 
        end
      }
    end

  end
end
