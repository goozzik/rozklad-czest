RozkladCzestPl::Application.routes.draw do

  get "schedules/stations"

  get "schedules/station"

  get "schedules/road"

  get "schedules/schedule"

  get "log_out" => "sessions#destroy", :as => "log_out"

  resources :users do
    resources :favourites
  end

  resources :sessions

  root :to => 'pages#index'
  post 'pages/get_location'
  get 'pages/static_map'
  get 'pages/info'
  get 'search_schedule/new_search'
  get 'search_schedule/autocomplete_station_name'
  get 'search_schedule/search'
  get 'search_schedule/map'

end
