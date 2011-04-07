RozkladCzestPl::Application.routes.draw do

  get "log_out" => "sessions#destroy", :as => "log_out"
  resources :users
  resources :sessions

  root :to => 'pages#index'
  resources :favourites
  post 'pages/get_location'
  get 'pages/static_map'
  get 'pages/info'
  get 'search_schedule/new_search'
  get 'search_schedule/autocomplete_station_name'
  get 'search_schedule/search'
  get 'search_schedule/map'

end
