Rails.application.routes.draw do
  scope module: "api", as: "api" do
    namespace :v1, defaults: { format: :json } do
      resources :levels
      resource :ping, only: [:show]
    end
  end
end
