ThreeminsServer::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  use_doorkeeper do
    controllers :tokens => "doorkeeper/custom_tokens"
  end

  # devise_for :users

  root :to => "home#index"

  namespace :api do
    namespace :v1 do
      post 'pushers/auth', to: 'pushers#auth'
      resources :users, :only => [:index, :show, :update] do
        collection do
          get :current
          get :existence
          get :facebook
        end

        member do
          get :products
          get :followers
          get :followings
        end
      end

      resources :categories, :only => [:index, :show] do
        collection do
          get :taggable
          get :display
        end
      end

      resources :products, :except => [:new, :edit] do
        resource :likes, only: [:create, :destroy, :index]

        collection do
          get :me
          get :offer
          get :liked
          get :search
          get :popular
          get :followed
        end

        get :show_offer, on: :member
        get :sold, on: :member

        resources :comments, only: [:index, :create]
      end

      resources :comments, only: [:update, :destroy]

      resources :conversations, only: [:create, :index, :show] do
        resources :conversation_replies, only: :create do
          post :bulk_create, on: :collection
        end
        put :offer, on: :member
        get :exist, on: :collection
      end

      resources :transactions, :except => [:new, :edit, :destroy] do
        collection do
          get :buys
          get :sells
        end
      end

      resources :activities, only: :index

      resources :relationships, only: :create do
        delete :unfollow, on: :collection
      end
    end
  end
end
