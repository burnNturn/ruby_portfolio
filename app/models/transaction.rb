class Transaction < ActiveRecord::Base
    require 'csv'
    
    # before_save :get_portfolio_id
    before_save :calculate_amounts
    before_save :find_holding
    before_save :build_description
    before_save :update_portfolio_balance
    
    belongs_to :user
    belongs_to :holding
    belongs_to :portfolio
    
    def self.import(file, portfolio)
        CSV.foreach(file.path, headers: true) do |row|
            hash = row.to_hash
            hash[:portfolio_id] = portfolio.id
            hash[:user_id] = portfolio.user.id
            Transaction.create! hash
        end
    end
    
    
    protected
    
    def calculate_amounts
        if self.amount.nil?
            self.amount = (self.quantity * self.price) + self.commission + self.fees
        end
    end
    
    def find_holding()
        if self.holding.present?
            @holding = self.holding
            if self.activity == 'Sell'
                @holding.sell_holding(self.quantity, self.price)
            elsif self.activity == 'Buy'
                @holding.buy_holding(self.quantity. self.price)
            end
        elsif Holding.where(user: self.user, portfolio: self.portfolio, symbol: self.symbol).exists?
            @holding = Holding.where(user: self.user, portfolio: self.portfolio, symbol: self.symbol).first
            if self.activity == 'Buy'
                @holding.buy_holding(self.quantity, self.price)
            end
        elsif !self.symbol.nil?
            @holding = Holding.create(user: self.user, portfolio: self.portfolio, 
                symbol: self.symbol, quantity: self.quantity,
                cost_basis: self.price, avg_price: self.price)
        else
            @holding = nil
        end
        
        self.holding = @holding
    end
    
    def build_description
        if self.symbol.nil?
            self.description = self.activity + " of " + self.amount.to_s
        else
            self.description = self.activity + " " + self.quantity.to_s + " shares of " + 
            self.symbol + " @ " + self.price.to_s
        end
    end
    
    def update_portfolio_balance
        if self.activity == 'Buy' or self.activity == 'Withdraw'
           self.portfolio.update_balance(self.amount * -1)
           self.debit = self.amount * -1
           self.balance = self.portfolio.cash_balance
        elsif self.activity == 'Sell' or self.activity == 'Contribution' or self.activity == 'Dividend'
            self.portfolio.update_balance(self.amount)
            self.credit = self.amount
            self.balance = self.portfolio.cash_balance
        end
    end
    
    
    
    # def get_portfolio_id
    #     #byebug
    #     self.portfolio_id = self.holding.portfolio.id
    #     #byebug
    #     return self.portfolio_id
    # end
end
