Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :admin, path: 'admin' do
    resources :customers, only: [:index, :show, :edit, :update, :destroy], as: :admin_customers
    resources :jitikais, only: [:new, :create, :index, :show, :edit, :update, :destroy], as: :admin_jitikais do
      post 'favorite' => 'jitikais#favorite_create'
      delete 'favorite' => 'jitikais#favorite_destroy'
    end
    resources :dusts, only: [:new, :create, :index, :show, :edit, :update, :destroy], as: :admin_dusts do
      post 'favorite' => 'dusts#favorite_create'
      delete 'favorite' => 'dusts#favorite_destroy'
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy], as: :admin_posts do
      post 'favorite' => 'posts#favorite_create'
      delete 'favorite' => 'posts#favorite_destroy'
      resources :post_comments, only: [:create]
    end
    resources :events, only: [:new, :create, :index, :show, :edit, :update, :destroy], as: :admin_events do
      post 'favorite' => 'events#favorite_create'
      delete 'favorite' => 'events#favorite_destroy'
      resources :event_comments, only: [:create]
    end
    resources :topics, only: [:index, :edit, :create, :update], as: :admin_topics
    resource :favorites, only: [:create, :destroy]

  end

  scope module: :public do
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :jitikais, only: [:index, :show] do
      post 'favorite' => 'jitikais#favorite_create'
      delete 'favorite' => 'jitikais#favorite_destroy'
    end
    resources :dusts, only: [:index, :show] do
      post 'favorite' => 'dusts#favorite_create'
      delete 'favorite' => 'dusts#favorite_destroy'
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      post 'favorite' => 'posts#favorite_create'
      delete 'favorite' => 'posts#favorite_destroy'
      resources :post_comments, only: [:create]
    end
    resources :events, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      post 'favorite' => 'events#favorite_create'
      delete 'favorite' => 'events#favorite_destroy'
      resources :event_comments, only: [:create]
    end
    resources :topics, only: [:index], as: :public_topics
    resource :favorites, only: [:create, :destroy]

  end

  root to: "homes#top"
  get "search" => "searches#search"
  get '/homes/about' => "homes#about",as: 'about'

end