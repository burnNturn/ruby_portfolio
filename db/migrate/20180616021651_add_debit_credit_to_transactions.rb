class AddDebitCreditToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :debit, :decimal
    add_column :transactions, :credit, :decimal
    add_column :transactions, :balance, :decimal
  end
end
