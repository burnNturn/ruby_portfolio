class Portfolio < ActiveRecord::Base
    include Xirr
    
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
    
    def get_todays_beg_balance
       todays_balance = self.balances.where(date: Date.current).first
       todays_balance.value
    end
    
    def ytd_perc
        ytd_perc = (ytd_change / self.beg_year_balance) * 100
        ytd_perc.round(2)
    end
    
    def ytd_xirr
        cf = Cashflow.new
        
        if self.beg_year_balance > 0
            cf << Transaction.new(portfolio.beg_year_balance * -1, date: Date.today.beginning_of_year)
            puts (portfolio.beg_year_balance * -1).to_s + ', date:' + Date.today.beginning_of_year.to_s
        end
        
        self.contributions.each do |transaction|
            amount = 0
            if !transaction.debit.nil?
                amount = transaction.debit
            elsif !transaction.credit.nil?
                amount = transaction.credit
            else
                amount = 0
            end
            if amount.nil?
            end
            cf << Transaction.new(amount * -1, date: transaction.date)
            puts (amount * -1).to_s + ', date:' + transaction.date.to_s 
        end
        
        @balances = self.balances
        @end_of_year_balance = @balances.where(:yearly => true, :date => Date.today.beginning_of_year).first
        cf << Transaction.new(@end_of_year_balance.value, date: Date.today.beginning_of_year.yesterday)
        puts (@end_of_year_balance.value).to_s + ', date:' + Date.today.beginning_of_year.yesterday.to_s
        
        cf.xirr * 100
    end
    
    def contributions
        contributions = []
        self.transactions.each do |transaction|
            if transaction.activity == "Contribution" or transaction.activity == "Withdraw"
                contributions << transaction
            end
        end
        contributions
    end
end
