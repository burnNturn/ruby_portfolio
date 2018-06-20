class Portfolio < ActiveRecord::Base
    before_create :calculate_total_value
    after_find :update_portfolio
    
    belongs_to :user
    has_many :holdings
    has_many :transactions
    has_many :balances
    validates :user_id, presence: true
    
    def update_portfolio
        calculate_total_value
    end
    
    def update_balance(amount)
        self.cash_balance += amount
        self.save
    end
    
    def calculate_total_value
        self.total_value = self.calculate_equities_value + self.cash_balance
    end
    
    def calculate_equities_value
        self.equities_value = 0
        self.holdings.each do |holding|
            self.equities_value += holding.current_value
        end
        self.equities_value
    end
    
    def get_beg_quarter_balance
        self.beg_quarter_balance
    end
    
    def get_beg_year_balance
        self.beg_year_balance
    end
    
    def ytd_change
        self.total_value - self.beg_year_balance
    end
    
    def ytd_perc
        ytd_perc = (ytd_change / self.beg_year_balance) * 100
        ytd_perc.round(2)
    end
end
