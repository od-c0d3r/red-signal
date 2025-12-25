Rails.application.routes.draw do
  root "static_pages#index"

  get "up" => "rails/health#show", as: :rails_health_check
  devise_for :users

  get "user_dashboard", to: "static_pages#user", as: :user_dashboard
  get "admin_dashboard", to: "static_pages#admin", as: :admin_dashboard
end
