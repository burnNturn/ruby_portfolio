class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.belongs_to :portfolio, index: true
      
      t.boolean :yearly
      t.boolean :quarterly
      t.boolean :monthly
      t.boolean :weekly
      t.date :date
      t.decimal :value

      t.timestamps null: false
    end
  end
end
