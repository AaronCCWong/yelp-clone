Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'api/sessions#omniauth'
  post '/rate' => 'rater#create', :as => 'rate'
  root 'root#home'

  namespace :api, defaults: { format: :json } do
    get "/search", to: "search#search"

    resources :restaurants, only: [:index, :create, :new, :show] do
      resources :reviews, only: [:create, :new]
    end

    resource :session, only: [:create, :show, :destroy]
    resources :users
    resources :reviews, only: [:index, :update, :edit, :destroy]
  end
end
