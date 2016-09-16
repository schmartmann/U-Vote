Rails.application.routes.draw do
  root to: 'home#index'

  resources :home
  resources :participation
  resources :rankings
  resources :register
end
