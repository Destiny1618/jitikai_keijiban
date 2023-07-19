Rails.application.routes.draw do
  namespace :public do
    resources :posts, only: [:new, :index, :show, :edit]
  end
  namespace :public do
    gresources :topics, only: [:index, :show]
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
root to: "homes#top"
get '/homes/about' => "homes#about",as: 'about'
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create]
  end
end