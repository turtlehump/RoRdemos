Rails.application.routes.draw do

  devise_for :users
  resources :images do
    resources :tags, shallow: true
    resources :iage_users, shallow: true
  end

  root 'images#index'

end
