FactoryBot.define do
    factory :portfolio do
        user
        name "portfolio_test"
        equities_value 712.2
        cash_balance 221.35
    end
end