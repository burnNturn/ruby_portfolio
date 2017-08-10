class Transaction < ActiveRecord::Base
    before_save :get_portfolio_id
    
    belongs_to :user
    belongs_to :holding
    belongs_to :portfolio
    
    protected
    
    def get_portfolio_id
        self.portfolio_id = self.holding.portfolio.id
    end
end
