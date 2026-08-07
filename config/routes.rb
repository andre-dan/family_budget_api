# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories, only: [ :index, :create ]
      resources :transactions, only: [ :index, :create, :destroy ]
      get "dashboard/summary", to: "dashboard#summary"
    end
  end
end
