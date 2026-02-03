Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { sessions: "users/sessions" }
  devise_scope :user do
    root to: "application#redirection"
  end

  namespace "admins" do get "dashboard" end

  namespace "users" do
    get "dashboard"
    post "update_status"
    post "update_location"
  end

  resources :events
  get "searching_nearby" => "events#searching_nearby"
end
