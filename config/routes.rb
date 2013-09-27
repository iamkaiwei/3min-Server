ThreeminsServer::Application.routes.draw do
  use_doorkeeper
	devise_for :users

	root :to => "home#index"

	namespace :api do
		namespace :v1 do
			resources :users, :only => [:index, :show, :update] do
				collection do
					get :existence
					get :facebook
				end
			end

			resources :categories, :only => [:index, :show]

			resources :products, :except => [:new, :edit]

			resources :transactions, :except => [:new, :edit, :destroy] do
				collection do
					get :buys
					get :sells
				end
			end
		end
	end
end
