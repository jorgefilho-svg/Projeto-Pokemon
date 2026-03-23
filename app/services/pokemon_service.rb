class PokemonService
  include HTTParty
  base_uri "https://pokeapi.co/api/v2"

  def initialize(pokemon_name_or_id)
    @query = pokemon_name_or_id.to_s.downcase
  end

  def execute
    pokemon_local = Pokemon.find_by(name: @query)

    if pokemon_local
      pokemon_local.touch # att para manter o registro como recente
      return {
        id: pokemon_local.poke_id,
        name: pokemon_local.name,
        types: pokemon_local.types.split(", "),
        weight: pokemon_local.weight,
        height: pokemon_local.height,
        base_experience: pokemon_local.base_experience,
        evolution_chain: pokemon_local.evolutions.split(", ")
      }
    end

    # Busca dados do Pokémon
    pokemon_response = self.class.get("/pokemon/#{@query}")
    return nil unless pokemon_response.success?

    # Busca a espécie para encontrar a URL das evolucoes
    species_url = pokemon_response["species"]["url"]
    species_response = HTTParty.get(species_url)

    # Busca as evolucoes
    evo_chain_url = species_response["evolution_chain"]["url"]
    evo_chain_response = HTTParty.get(evo_chain_url)

    pokemon_data = build_response(pokemon_response, evo_chain_response)

    if pokemon_data
      Pokemon.create(
        poke_id: pokemon_data[:id],
        name: pokemon_data[:name],
        types: pokemon_data[:types].join(", "),
        weight: pokemon_data[:weight],
        height: pokemon_data[:height],
        base_experience: pokemon_data[:base_experience],
        evolutions: pokemon_data[:evolution_chain].join(", ")
      )
    end

    pokemon_data

  rescue StandardError => e
    puts "Erro ao buscar dados do Pokémon: #{e.message}"
    nil
  end

  private

  def build_response(poke_data, evo_data)
    {
      id: poke_data["id"],
      name: poke_data["name"],
      types: poke_data["types"].map { |t| t["type"]["name"] },
      weight: poke_data["weight"],
      height: poke_data["height"],
      base_experience: poke_data["base_experience"],
      evolution_chain: parse_evolution_chain(evo_data["chain"])
    }
  end

  # Método recursivo para pegar todas as evoluções (incluindo ramificações maiores tipo Eevee)
  def parse_evolution_chain(chain_data)
    family = [ chain_data["species"]["name"] ]

    if chain_data["evolves_to"].present?
      chain_data["evolves_to"].each do |evolution|
        family += parse_evolution_chain(evolution)
      end
    end

    family
  end
end
