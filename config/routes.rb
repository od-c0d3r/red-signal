Rails.application.routes.draw do
  root "static_pages#index"
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  resources :events

  get "user_dashboard", to: "static_pages#user", as: :user_dashboard
  post "update_status", to: "users#update_status", as: :update_status
  post "update_location", to: "users#update_location", as: :update_location
  get "admin_dashboard", to: "static_pages#admin", as: :admin_dashboard
end
