Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get '/fanfics', to: 'fanfics#index', as: :fanfics
    root 'fanfics#index'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :users, only: [:new, :create, :show, :index, :destroy] do
      collection do
        put :update_attribute_on_the_spot
        get :get_attribute_on_the_spot
      end
      member do
        get :activate, :make_admin, :block, :unblock
      end
      resources :fanfics, except: [:index], shallow: true do
        resources :chapters, except: [:index], shallow: false do
          resources :likes, only: [:create, :destroy]
        end
        resources :comments, only: [:create, :index, :destroy]
      end
    end
    get '/sign_up', to: 'users#new', as: :sign_up
    resources :sessions, only: [:new, :create, :destroy]
    get '/log_in', to: 'sessions#new', as: :log_in
    delete '/log_out', to: 'sessions#destroy', as: :log_out
    post '/new_rating', to: 'rating#create'
    get "search", to: "search#search"
    get "tag_search", to: "search#tag_search"
    get 'tags/:tag', to: 'fanfics#index', as: :tag
    post '/chapters_sort', to: 'chapters#sort'
    get '/user_locale', to: 'users#user_locale'
  end
end
