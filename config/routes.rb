Rails.application.routes.draw do

  devise_for :users

  root to: 'welcome#index'
  get 'data_services/update_tables', to: 'data_services#update_tables'


  resources :welcome, only: [:index]

  resources :datasources

  resources :data_services
  resources :scenes do
    resources :quatilty
  end

  resources :view_points
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
