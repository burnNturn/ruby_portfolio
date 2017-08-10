class Holding < ActiveRecord::Base
    before_save :calculate_cost_basis
    
    belongs_to :user
    belongs_to :portfolio
    
    has_many :transactions
    
    protected
    
    def calculate_cost_basis
        self.cost_basis = self.quantity * self.avg_price
    end
end
