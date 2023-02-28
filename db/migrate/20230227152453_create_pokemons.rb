class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :height
      t.integer :weight
      t.string :image_path
      t.decimal :price, precision: 10, scale: 2, default: 0
      t.decimal :last_sell_price, precision: 10, scale: 2, default: 0
      t.references :user, foreign_key: true
    end
  end
end
