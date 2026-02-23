class PokemonsController < ApplicationController
before_action :verificar_login
def show
    # Captura o parâmetro da URL (nome ou id)
    query = params[:id]

    # Chama o serviço para buscar os dados do Pokémon
    result = PokemonService.new(query).execute

    if result
      render json: result, status: :ok
    else
      render json: { error: "Pokémon não encontrado" }, status: :not_found
    end
  end
end
