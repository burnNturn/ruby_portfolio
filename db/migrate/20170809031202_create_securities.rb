class CreateSecurities < ActiveRecord::Migration
  def change
    create_table :securities do |t|
      t.string    :symbol
      t.string    :asset_class
      t.string    :description
      t.string    :identifier
      t.decimal   :previous_close
      t.decimal   :current_price
      t.datetime  :last_api_call
      
      t.timestamps null: false
    end
  end
end
