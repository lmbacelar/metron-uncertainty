Metron::Application.routes.draw do
  resources :model
  root      'model#index'
end
