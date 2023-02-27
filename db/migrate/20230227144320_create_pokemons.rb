class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :weight
      t.integer :height
      t.integer :price
      t.text :image_path
      t.timestamps
    end
  end
end
