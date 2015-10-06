Rails.application.routes.draw do

  root "home#index"

  get 'check', to: 'home#show'

end
