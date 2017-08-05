json.extract! portfolio, :id, :name, :total_value, :equities_value, :cash_balance, :created_at, :updated_at
json.url portfolio_url(portfolio, format: :json)
