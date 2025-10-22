Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Root path
  root "welcome#index"

  # API routes
  namespace :api do
    namespace :v1 do
      resources :users
      resources :scales
      resources :projects
      resources :surveys
      resources :analyses
      resources :credit_transactions
      resources :responses
      resources :scale_items
    end
  end
end