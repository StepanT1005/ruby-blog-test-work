
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  resources :posts do
    resources :comments, only: [:create]
  end

  root 'posts#index'
end
