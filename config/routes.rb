Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :subsidiaries, only: %i[index]
  resources :cars, only: %i[index]

end
