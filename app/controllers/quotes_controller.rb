class QuotesController < ApplicationController

    def get_quick_quote
        @security = Security.where(symbol: app_params[:symbol]).first
        if !@security.present? 
            @security = Security.new
            @security.load_security(symbol)
            @security.save
        end
        @security.update_security
        @quote = @security.current_price
        # begin 
        #   @security = Security.where(symbol: app_params[:symbol]).first
        # rescue 
        # end
        # if !@security.present? 
        #   @security = Security.create(params[app_params[:symbol]])
        # end
        # @quote = @security.get_quote
        # # render 'js', template: 'layouts/get_quick_quote'
    end

end