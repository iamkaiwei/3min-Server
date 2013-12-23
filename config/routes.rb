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
					post :device_token
				end
			end

			resources :categories, :only => [:index, :show]

			resources :products, :except => [:new, :edit] do
				resources :chats, only: [:create, :index]
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
