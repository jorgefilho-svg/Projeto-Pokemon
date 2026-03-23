class FavoritesController < ApplicationController
  before_action :verificar_login

  def create
    pokemon = Pokemon.find_by(name: params[:pokemon_name])

    if current_user.pokemons.include?(pokemon)
    else
      current_user.pokemons << pokemon
    end

    redirect_to home_path
  end

  def destroy
    pokemon = Pokemon.find_by(name: params[:pokemon_name])

    if pokemon && current_user.pokemons.include?(pokemon)
      current_user.pokemons.delete(pokemon)
    end

    redirect_to home_path
  end
end
