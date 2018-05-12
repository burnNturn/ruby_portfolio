FactoryBot.define do
    factory :holding do
        user
        portfolio
        # security
        symbol "AAPL"
        asset_class "equity"
        quantity 10
        date_opened "2017-08-09"
        cost_basis 22.8
        avg_price 27.0
    end
    
    factory :invalid_holding, parent: :holding do
        symbol nil
    end
    
end