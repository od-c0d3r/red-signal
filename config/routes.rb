Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  devise_for :users, controllers: { sessions: "users/sessions" }
  devise_scope :user do root to: "static_pages#index" end

  get "admin", to: "static_pages#admin"

  resources :events

  scope "admin" do
    get "searching_nearby" => "events#searching_nearby"
  end

  get "users/dashboard"

  post "update_status" => "users#update_status"
  post "update_location" => "users#update_location"
end
