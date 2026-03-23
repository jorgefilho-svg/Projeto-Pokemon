class PagesController < ApplicationController
  before_action :verificar_login

  def home
    @recentes = Pokemon.order(updated_at: :desc).to_a.uniq(&:name).first(5)
    if params[:pokemon_name].present?

      @pokemon = PokemonService.new(params[:pokemon_name]).execute

      if @pokemon.nil?
        @erro = "Pokémon '#{params[:pokemon_name]}' não encontrado. Tente outro!"
      end

    end
  end
end
