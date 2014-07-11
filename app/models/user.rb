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
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: "followed_id", class_name: Relationship
	has_many :followers, through: :reverse_relationships


	validates :password, :length => { :within => Devise.password_length }, :allow_blank => true
	validates :email, presence: true

	before_destroy :destroy_conversations

	%W(admin user).each do |type|
		define_method "#{type}?".to_sym do
			self.role == type
		end
	end

	def self.find_or_create_by_facebook(args)
		response = FacebookHelper.me(args[:fb_token], %W(email id username name first_name middle_name last_name gender birthday))
		return nil if response.empty?

		user = User.find_or_initialize_by(email: response[:email])
		user_parameters = {
			:facebook_id => response[:id],
			:username => response[:username],
			:full_name => response[:name],
			:first_name => response[:first_name],
			:middle_name => response[:middle_name],
			:last_name => response[:last_name],
			:gender => response[:gender],
			:birthday => response[:birthday],
			:avatar => "https://graph.facebook.com/#{response[:id]}/picture?type=large",
			:role => "user"
		}
		user_parameters[:udid] = args[:udid] if args[:udid].present?
		user.update(user_parameters)

		return user
	end

	def self.find_or_create_by_google args
		response = Google::Api.new(args[:gg_token]).user_info
		return nil unless response.success?

		user = User.find_or_initialize_by(email: response[:emails].first[:value])
		user_parameters = {
			:google_id => response[:id],
			:username => response[:username],
			:full_name => response[:displayName],
			:first_name => response[:name][:familyName],
			:last_name => response[:name][:givenName],
			:gender => response[:gender],
			:avatar => response[:image][:url],
			:role => "user"
		}
		user_parameters[:udid] = args[:udid] if args[:udid].present?
		user.update(user_parameters)

		return user
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

	def facebook_avatar
		avatar
	end

	private

		def destroy_conversations
			Conversation.of_you(self.id).destroy_all
		end
end
