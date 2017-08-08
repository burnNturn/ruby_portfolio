class ModulesController < ApplicationController
    
    def portfolios
       @user = current_user
       @portfolios = @user.portfolios
    end
    
end
