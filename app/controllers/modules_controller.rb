class ModulesController < ApplicationController
    
    def index
        @user = current_user
        @portfolios = @user.portfolios
        @holdings = @user.holdings
        @securities = Security.first(10)
        #intrinio = Intrinio.new()
    end
    
    def portfolios
       @user = current_user
       @portfolios = @user.portfolios
    end
    
end
