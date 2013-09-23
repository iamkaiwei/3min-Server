class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :omniauthable,
	# :registerable, :recoverable, :rememberable, :validatable
	devise :database_authenticatable, :registerable

	has_many :products, :dependent => :destroy
	has_many :transactions, :dependent => :destroy
	has_one :image, :as => :attachable, :dependent => :destroy

	before_save :ensure_authentication_token

private

	def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
	end

	def generate_authentication_token
		loop do
			token = Devise.friendly_token
			break token unless User.where(:authentication_token => token).first
		end
	end
end
