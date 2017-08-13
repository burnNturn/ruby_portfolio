class ModulesController < ApplicationController
    
    def index
       @user = current_user
       @portfolios = @user.portfolios
       @holdings = @user.holdings
       puts ENV["INTRINIO_PASSWORD"]
    end
    
    def portfolios
       @user = current_user
       @portfolios = @user.portfolios
    end
    
end
