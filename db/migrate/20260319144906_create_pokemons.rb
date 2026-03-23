class CreatePokemons < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :types
      t.string :evolutions
      t.integer :weight
      t.integer :height
      t.integer :base_experience

      t.timestamps
    end
  end
end
