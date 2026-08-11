Rails.application.routes.draw do
  root "home#index"
  get "check", to: "checks#show", as: :check
  get "facilities", to: "facilities#index", as: :facilities
end
