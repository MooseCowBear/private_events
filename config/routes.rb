Rails.application.routes.draw do
  get 'user/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "events#index"

  resources :user, only: [:show, :index]

  resources :events do
    resources :guest_lists, only: [:create, :destroy]
  end

  post '/events/:event_id/guest_lists/:id' => "guest_lists#destroy"
end
