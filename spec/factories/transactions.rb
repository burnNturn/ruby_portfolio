FactoryBot.define do
    factory :transaction do
        user
        holding
        portfolio
        
        date "2017-10-31"
        activity "bought"
        quantity 19
        symbol "AA"
        description "bought 19 shares of AA"
        price 3.12
        commission 4.95
        fees "0"
        amount 64.23
    end
    
    factory :invalid_transaction, parent: :transaction do
       symbol 0 
    end
end