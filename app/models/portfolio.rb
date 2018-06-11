class Portfolio < ActiveRecord::Base
    before_save :calculate_total_value
    
    belongs_to :user
    has_many :holdings
    has_many :transactions
    validates :user_id, presence: true
    
    def calculate_total_value
        self.total_value = self.equities_value + self.cash_balance
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
    
    def get_ytd_perc
        
    end
end
