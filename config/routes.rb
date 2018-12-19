Rails.application.routes.draw do
  resources :elves
  root 'home#index'
end
