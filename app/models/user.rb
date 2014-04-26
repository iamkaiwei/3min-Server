class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :omniauthable,
	# :registerable, :recoverable, :rememberable, :validatable
	devise :database_authenticatable, :registerable

	has_many :products, :dependent => :destroy
	has_many :transactions, :foreign_key => "buyer_id"
	has_many :transactions, :foreign_key => "seller_id"
	has_many :likes
	has_many :liked_products, :through => :likes, :source => :product
	has_one :image, :as => :attachable, :dependent => :destroy
	has_many :activities

	validates :password, :length => { :within => Devise.password_length }, :allow_blank => true

	before_destroy :destroy_conversations

	%W(admin user).each do |type|
		define_method "#{type}?".to_sym do
			self.role == type
		end
	end

	def self.find_or_create_by_facebook(args)
		return nil if args[:fb_token].blank?

		response = FacebookHelper.me(args[:fb_token], %W(email id username name first_name middle_name last_name gender birthday))

		return nil if response.empty?

		user = User.find_or_initialize_by(facebook_id: response[:id])
		return user if user.persisted?
		user_parameters = {
			:email => response[:email],
			:username => response[:username],
			:full_name => response[:name],
			:first_name => response[:first_name],
			:middle_name => response[:middle_name],
			:last_name => response[:last_name],
			:gender => response[:gender],
			:birthday => response[:birthday],
			:facebook_avatar => "https://graph.facebook.com/#{response[:id]}/picture?type=large",
			:role => "user"
		}
		user_parameters[:udid] = args[:udid] if args[:udid].present?
		user.update(user_parameters)

		return user
		# if user.blank?
		# 	user_parameters.merge!({
		# 		:facebook_id => response[:id],
		# 		:image => Image.create(:content => response[:picture])
		# 	})

		# 	user = User.create(user_parameters)
		# else
		# 	user.image.update_attributes(:content => response[:picture])
		# end

	end

	def alias_name
		"user-#{self.id}"
	end

	def conversations page
		conversations = Conversation.of_you(self.id).order(updated_at: :desc).paginate(:page => page).includes(:audience_one, :audience_two, :product)
		return nil if conversations.blank?
		replies = ConversationReply.latest_message(conversations.map(&:id)).pluck(:conversation_id, :reply)
															 .inject({}) { |rs, var| rs[var.first] = var.last; rs }
		conversations.each { |c| c.latest_message = replies[c.id] }
	end

	private

		def destroy_conversations
			Conversation.of_you(self.id).destroy_all
		end
end
