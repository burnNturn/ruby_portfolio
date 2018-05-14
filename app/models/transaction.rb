class Transaction < ActiveRecord::Base
    # before_save :get_portfolio_id
    before_save :calculate_amount
    before_save :find_holding
    before_save :build_description
    
    belongs_to :user
    belongs_to :holding
    belongs_to :portfolio
    
    protected
    
    def calculate_amount
        self.amount = (self.quantity * self.price) + self.commission + self.fees
    end
    
    def find_holding()
        
        if Holding.where(user: self.user, portfolio: self.portfolio, symbol: self.symbol).exists?
            @holding = Holding.where(user: self.user, portfolio: self.portfolio, symbol: self.symbol).first
            @holding.recalculate(self.quantity, self.amount)
        else
            @holding = Holding.create(user: self.user, portfolio: self.portfolio, 
                symbol: self.symbol, quantity: self.quantity,
                cost_basis: self.price, avg_price: self.amount)
        end
        
        self.holding = @holding
    end
    
    def build_description
       self.description = self.activity + " " + self.quantity.to_s + " shares of" + 
        self.symbol + " @ " + self.price.to_s
    end
    
    
    
    
    
    # def get_portfolio_id
    #     #byebug
    #     self.portfolio_id = self.holding.portfolio.id
    #     #byebug
    #     return self.portfolio_id
    # end
end
