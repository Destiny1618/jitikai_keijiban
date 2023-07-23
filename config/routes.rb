Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    resources :customers, only: [:show, :edit, :update]
    resources :jitikais, only: [:index, :show] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :dusts, only: [:index, :show] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create]
    end
    resources :events, only: [:new, :create, :index, :show, :edit, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :event_comments, only: [:create]
    end
    resources :topics, only: [:index]
  end

  root to: "homes#top"
  get "search" => "searches#search"
  get '/homes/about' => "homes#about",as: 'about'

end