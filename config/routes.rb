Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :levels
    resources :submissions, only: [:create, :show]

    resource :ping, only: [:show]
  end

  get "/game", to: "game#show"
  get "/level", to: "level#show"
end
