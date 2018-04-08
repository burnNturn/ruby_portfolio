FactoryBot.define do
    factory :portfolio do
        user
        name "portfolio_test"
        equities_value 712.2
        cash_balance 221.35
    end
    
    factory :invalid_portfolio, parent: :portfolio do
        name nil
    end
end