Rails.application.routes.draw do
  resources :users

  root 'static_pages#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
