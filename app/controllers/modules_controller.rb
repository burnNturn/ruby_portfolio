class ModulesController < ApplicationController
    
    def index
        @user = current_user
        @portfolios = @user.portfolios
        @holdings = @user.holdings
        byebug
        intrinio = Intrinio.new()
        puts intrinio.get_quote('AAPL')
    end
    
    def portfolios
       @user = current_user
       @portfolios = @user.portfolios
    end
    
end
