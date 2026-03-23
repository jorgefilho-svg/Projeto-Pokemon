Rails.application.routes.draw do
  root "sessions#new"

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  get  "/cadastro", to: "users#new"
  post "/users",    to: "users#create"

  get "/home", to: "pages#home"

  post "/favoritar", to: "favorites#create"
  delete "/desfavoritar", to: "favorites#destroy"

  get "/pokemons/:id", to: "pokemons#show"
end
