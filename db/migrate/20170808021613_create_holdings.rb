class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.belongs_to :user, index:true
      t.belongs_to :portfolio, index:true
      t.belongs_to :security, index:true
      
    
      t.string  :symbol
      t.string  :asset_class
      t.decimal :quantity
      t.date    :date_opened
      t.decimal :cost_basis
      t.decimal :avg_price

      
      t.timestamps null: false
    end
  end
end
