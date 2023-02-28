class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :pokemon_id
      t.integer :action, default: 0 # default value is the first value in the enum
      t.decimal :amount, precision: 10, scale: 2, default: 0
      t.timestamps
    end

    add_index :transactions, :user_id
    add_index :transactions, :pokemon_id
  end
end
