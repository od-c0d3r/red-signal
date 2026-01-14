Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  devise_scope :user do root to: "users/sessions#new" end

  get "up" => "rails/health#show", as: :rails_health_check

  resources :events

  get "admin", to: "static_pages#admin"

  scope "admin" do
    get "searching_nearby" => "events#searching_nearby"
  end

  get "user", to: "static_pages#user"

  post "update_status" => "users#update_status"
  post "update_location" => "users#update_location"
end
