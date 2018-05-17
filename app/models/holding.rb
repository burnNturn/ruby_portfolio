class Holding < ActiveRecord::Base
    before_save :calculate_cost_basis
    
    belongs_to :user
    belongs_to :portfolio
    
    has_many :transactions
    
    @@current_price_var = BigDecimal.new("0.00")
    # def initialize
    #     @@current_price_var = BigDecimal.new("0.00")
    # end
    
    def current_price
        @@current_price_var = Intrinio.instance.quick_quote(self.symbol)
    end
    
    def current_value
        self.quantity * @@current_price_var.to_d
    end
    
    def buy_holding(qty_bought, cost_of_bought)
       self.quantity += qty_bought
       self.cost_basis += cost_of_bought
       self.avg_price = self.cost_basis / self.quantity
       self.save
    end
    
    def sell_holding(qty_sold, funds_from_sold)
       self.quantity -= qty_sold
       self.cost_basis -= funds_from_sold
       self.avg_price = self.cost_basis / self.quantity
       self.save
    end
    
    protected
    
    def calculate_cost_basis
        byebug
        self.cost_basis = self.quantity * self.avg_price
    end
    
end
