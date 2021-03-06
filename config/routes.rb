Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :categories do
    resources :tasks
  end

  get '/calendar', to: 'calendar#show'
  get '/tasks', to: 'tasks#index'
end
