RozkladCzestPl::Application.routes.draw do

  get "schedules", :controller => 'schedules', :action => 'index', :as => 'schedules_index'
  get "stations", :controller => 'schedules', :action => 'stations', :as => 'schedules_stations'
  get "stations/:id", :controller => 'schedules', :action => 'station', :as => 'schedules_station'
  get "lines", :controller => 'schedules', :action => 'lines', :as => 'schedules_lines'
  get "lines/:number", :controller => 'schedules', :action => 'line', :as => 'schedules_line'
  get "line_road/:id", :controller => 'schedules', :action => 'line_road', :as => 'schedules_line_road'
  get "line_road_map/:id", :controller => 'schedules', :action => 'line_road_map', :as => 'schedules_line_road_map'
  get "schedules/schedule/:line_id/:station_id", :controller => 'schedules', :action => 'schedule', :as => 'schedules_schedule'

  get "log_out" => "sessions#destroy", :as => 'log_out'
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
