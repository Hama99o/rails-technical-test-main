class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :height
      t.integer :weight
      t.string :image_path
      t.integer :price, default: 0.0
      t.references :user, foreign_key: true
    end
  end
end
