class ModulesController < ApplicationController
    
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
