Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destination'
    post 'sending_destinations', to: 'users/registrations#create_sending_destination'
  end

  resources :credit_cards, only: [:new, :show] do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end

  resources :exhibition, only: :index
  resources :items, only: [:index, :show] do
    resources :buy, only: :index do
      collection do
        post 'pay', to: 'buy#pay'
      end
    end
  end

  root "items#index"

  resources :items, only: [:index, :show, :new, :create, :edit, :destroy] do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
  
  resources :credit_cards
  resources :mypages do
    collection do
      get :logout
    end
  end
end
