RozkladCzestPl::Application.routes.draw do

  get "sessions/new"

  get "users/new"

  root :to => 'pages#index'
  resources :favourites
  post 'pages/get_location'
  get 'pages/static_map'
  get 'pages/errors'
  get 'search_schedule/new_search'
  get 'search_schedule/autocomplete_station_name'
  get 'search_schedule/search'
  get 'search_schedule/map'

end
