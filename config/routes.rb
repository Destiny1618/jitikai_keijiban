Rails.application.routes.draw do
  scope module: :public do
    resources :customers, only: [:show, :edit]
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
      resources :post_comments, only: [:create]
    end
    resources :topics, only: [:index]
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
root to: "homes#top"
get "search" => "searches#search"
get '/homes/about' => "homes#about",as: 'about'
  
end