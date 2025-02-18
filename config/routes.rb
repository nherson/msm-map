Rails.application.routes.draw do
  root "home#index"
  get "home/index"

  # Garbage stuff used as a test playground
  get "test_area/index"
  get "test_area/experience", to: "test_area#experience"
  get "test_area/:type", to: "test_area#show"

  get "experiences", to: "experience#index"
  get "experiences/:tag", to: "experience#show", as: :experience

  # Admin routes
  post "cache/refresh"
  get "up" => "rails/health#show", as: :rails_health_check
end
