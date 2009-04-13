module Troper
  module Formatters
    def link_to_mail(input, label=nil)
      "<a href='mailto:#{input}'>#{label||input}</a>"
    end
    def format_phone_number(input)
      if input =~ /(\d{2})(\d{4})(\d{4})/ 
        sprintf("(%s) %s-%s", $1, $2, $3) 
      else 
        "[no valid]"  
      end 
    end
  end
end

