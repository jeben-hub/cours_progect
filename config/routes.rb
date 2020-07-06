Rails.application.routes.draw do
  get '/fanfics', to: 'fanfics#index'
  root 'fanfics#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :show, :create, :destroy] do
    member do
      get :activate
    end
    resources :fanfics, except: [:index], shallow: true do
      resources :comments, only: [:create, :index, :destroy]
    end
  end
  get '/sign_up', to: 'users#new', as: :sign_up
  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
end
