class IntriniosController < ApplicationController
   
   def get_quick_quote
      @quick_quote = Intrinio.instance.quick_quote(intrinio_params) 
   end
    
    
    private
    
    def intrinio_params
       params.permit(:symbol) 
    end
end