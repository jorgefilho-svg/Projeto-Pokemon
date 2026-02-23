Rails.application.routes.draw do
  # rota do pokemom
  get "/pokemons/:id", to: "pokemons#show"
  # rota de criação de usuário
  post "/users", to: "users#create"
  # rota de login
  post "/login", to: "sessions#create"
end
