class DailyWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :default
    
    def perform
        
        Portfolio.all.each do |portfolio|
            portfolio.calculate_equities_value
            value = portfolio.calculate_total_value
            @balance = Balance.create(portfolio: portfolio, date: Date.today, value: value)
            @balance.save
        end
            
        
    end
end