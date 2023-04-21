Rails.application.routes.draw do
  resources :boards, only: [:index, :show, :create, :update, :destroy] do
    resources :columns, only: [:index, :show, :create, :update, :destroy] do
      resources :stories, only: [:index, :show, :create, :update, :destroy]
    end
  end
end