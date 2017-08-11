class ModulesController < ApplicationController
    
    def index
       @user = current_user
       @portfolios = @user.portfolios
       @holdings = @user.holdings
    end
    
    def portfolios
       @user = current_user
       @portfolios = @user.portfolios
    end
    
end
