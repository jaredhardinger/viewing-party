# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  post '/dashboard', to: 'users#create'
  get '/dashboard/discover', to: 'movies#discover'
  get '/dashboard/movies', to: 'movies#index'
  get '/dashboard/movies/:id', to: 'movies#show'
  get '/dashboard/parties/new', to: 'parties#new'
  post '/dashboard/parties', to: 'parties#create'
end
