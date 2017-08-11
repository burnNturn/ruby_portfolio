class Portfolio < ActiveRecord::Base
    before_save :calculate_total_value
    
    belongs_to :user
    has_many :holdings
    has_many :transactions
    validates :user_id, presence: true
    
    def calculate_total_value
        self.total_value = self.equities_value + self.cash_balance
    end
end
