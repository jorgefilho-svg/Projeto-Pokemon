class AddPokeIdToPokemons < ActiveRecord::Migration[8.1]
  def change
    add_column :pokemons, :poke_id, :integer
  end
end
