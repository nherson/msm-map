Rails.application.routes.draw do
  root "home#index"
  get "home/index"

  # Garbage stuff used as a test playground
  get "test_area/index"
  get "test_area/:type", to: "test_area#show"

  # Admin routes
  get "cache/refresh"
  get "up" => "rails/health#show", as: :rails_health_check
end
