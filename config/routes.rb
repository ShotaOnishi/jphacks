Rails.application.routes.draw do
  resources :homes
  post '/callback' => 'webhook#callback'
  root :to => 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
