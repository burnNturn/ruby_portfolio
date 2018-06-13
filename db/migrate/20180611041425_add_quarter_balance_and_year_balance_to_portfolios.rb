class AddQuarterBalanceAndYearBalanceToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :beg_quarter_balance, :decimal
    add_column :portfolios, :beg_year_balance, :decimal
  end
end
