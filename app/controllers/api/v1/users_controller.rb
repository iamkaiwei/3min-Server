class Api::V1::UsersController < Api::BaseController
	skip_before_filter :authenticate_user_with_token!, :only => :login
	skip_before_filter :authenticate_user!, :only => :login

	def index
		@users = if params[:per_page].present? or params[:page].present?
						User.includes(:images).paginate(:page => params[:page], :per_page => params[:per_page])
					else
						User.all
					end
	end

	def show; end

	def update
	end

	def existence
	end

	def facebook
	end

	def login
		response = FacebookHelper.me(login_params[:fb_token], %W(email id username name first_name middle_name last_name gender birthday picture.type(large)))

		return render_failure if response.empty?

		user = User.find_by_facebook_id(response[:id])

		if user.blank?
			user_parameters = {
				:email => response[:email],
				:facebook_id => response[:id],
				:username => response[:username],
				:full_name => response[:name],
				:first_name => response[:first_name],
				:middle_name => response[:middle_name],
				:last_name => response[:last_name],
				:gender => response[:gender],
				:birthday => response[:birthday],
				:image => Image.create(:content => response[:picture]),
				:udid => login_params[:udid]
			}

			user = User.new(user_parameters)

			return render_failure(:details => user.errors.full_messages.join("\n")) unless user.save
		end

		user.ensure_authentication_token!

		render_success(:user => render_json_rabl(user, :show), :auth_token => user.authentication_token)
	end

	def logout
		current_user.update_attributes(:authentication_token => nil)

		render_success
	end

	private

	def login_params
		params.permit(:fb_token, :udid)
	end

	def user_params
	end
end
