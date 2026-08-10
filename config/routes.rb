Rails.application.routes.draw do
  root "home#index"
  get "check", to: "checks#show", as: :check

end
