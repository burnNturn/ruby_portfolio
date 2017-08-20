class ModulesController < ApplicationController
    before_action :authenticate_user!
    
    def index
        
        @user = current_user
        @portfolios = @user.portfolios
        @holdings = @user.holdings
        #intrinio = Intrinio.new()
    end
    
    def portfolios
       @user = current_user
       @portfolios = @user.portfolios
    end
    
end
