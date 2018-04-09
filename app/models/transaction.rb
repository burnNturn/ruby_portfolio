class Transaction < ActiveRecord::Base
    # before_save :get_portfolio_id
    
    belongs_to :user
    belongs_to :holding
    belongs_to :portfolio
    
    protected
    
    # def get_portfolio_id
    #     #byebug
    #     self.portfolio_id = self.holding.portfolio.id
    #     #byebug
    #     return self.portfolio_id
    # end
end
