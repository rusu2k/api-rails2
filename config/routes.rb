Rails.application.routes.draw do
  # devise_for :users, controllers: {
  #   registrations: 'users/registrations'
  # }
  devise_for :users
  # devise_for :users, controllers: {
  #    sessions: 'users/sessions'
  # }

  resources :boards, only: [:index, :show, :create, :update, :destroy] do
    resources :columns, only: [:index, :show, :create, :update, :destroy] do
      resources :stories, only: [:index, :show, :create, :update, :destroy]
    end
  end
end