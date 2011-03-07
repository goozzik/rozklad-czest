RozkladCzestPl::Application.routes.draw do
  root :to => 'pages#index'
  resources :favourites
  get 'pages/map'
  get 'search_schedule/new_search'
  get 'search_schedule/autocomplete_station_name'
  get 'search_schedule/map'
    
  post 'search_schedule/search'
  post 'pages/get_location'
end

