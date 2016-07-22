require 'sidekiq/web'
Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end if Rails.env.production?

  mount Sidekiq::Web, at: "/sidekiq"

  namespace :api, defaults: { format: :json } do
    resource :game_session

    resources :levels
    resources :submissions, only: [:create, :show]

    resource :ping, only: [:show]
  end

  root to: "menu#show"
  get "/game", to: "game#show"
  get "/summary", to: "summary#show"
  get "/credits", to: "credits#show"
end
