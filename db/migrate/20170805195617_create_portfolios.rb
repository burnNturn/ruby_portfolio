class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.belongs_to :user, index:true
      t.string :name
      t.decimal :total_value
      t.decimal :equities_value
      t.decimal :cash_balance

      t.timestamps null: false
    end
  end
end
