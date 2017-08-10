class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user
      t.belongs_to :holding
      t.belongs_to :portfolio
      
      t.date    :date
      t.string  :activity
      t.decimal :quantity
      t.string  :symbol
      t.string  :description
      t.decimal :price
      t.decimal :commission
      t.decimal :fees
      t.decimal :amount
      
      t.timestamps null: false
    end
  end
end
