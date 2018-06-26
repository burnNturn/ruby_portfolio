module Calculations
    include Xirr
    
    def ytd_xirr(portfolio)
        cf = Cashflow.new
        
        if portfolio.beg_year_balance > 0
            cf.Transaction(portfolio.beg_year_balance * -1, date: Date.today.beginning_of_year)
        end
        
        portfolio.contributions.each do |transaction|
            cf.Transaction(transaction.debit + transaction.credit, date: transaction.date)
        end
        
    end
end