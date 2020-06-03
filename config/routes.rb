Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get '/' => 'books#top'

  root to: "home#top"

  get "users/:id" => "users#show", as: :mypage
  get "home/top" => "home#top", as: :top
  get "home/about" => "home#about"

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end


