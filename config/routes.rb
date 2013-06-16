Metron::Application.routes.draw do
  resources :models
  root      'models#index'
end
