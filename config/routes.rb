Metron::Application.routes.draw do
  resources :measurement_model
  root      'measurement_model#index'
end
