Rails.application.routes.draw do

  get 'reps/index'

  get 'coaches/index'

  resources :users
  resources :admins
  resources :managers
  resources :coaches
  resources :reps

  root 'static_pages#home'

  get     '/signup',  to: 'users#new'
  post    '/signup',  to: 'users#create'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/login',   to: 'sessions#destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
