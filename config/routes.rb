ThreeminsServer::Application.routes.draw do
  ActiveAdmin.routes(self)
	use_doorkeeper do
		controllers :tokens => "doorkeeper/custom_tokens"
	end

	devise_for :users

	root :to => "home#index"

	namespace :api do
		namespace :v1 do
			resources :users, :only => [:index, :show, :update] do
				collection do
					get :current
					get :existence
					get :facebook
				end
			end

			resources :categories, :only => [:index, :show]

			resources :products, :except => [:new, :edit] do
				resource :likes, only: [:create, :destroy]
				get :me, on: :collection
				get :offer, on: :collection
				get :liked, on: :collection
			end

			resources :conversations, only: [:create, :index, :show] do
				resources :conversation_replies, only: :create
				put :offer, on: :member
			end

			resources :transactions, :except => [:new, :edit, :destroy] do
				collection do
					get :buys
					get :sells
				end
			end

		end
	end
end
