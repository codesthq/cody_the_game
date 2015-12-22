Rails.application.routes.draw do
  scope module: "api", as: "api" do
    namespace :v1, defaults: { format: :json } do
      resources :levels
      resources :submissions, only: [:create, :show]

      resource :ping, only: [:show]
    end
  end

  get "/game", to: "game#show"
end
