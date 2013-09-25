class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :omniauthable,
	# :registerable, :recoverable, :rememberable, :validatable
	devise :database_authenticatable, :registerable

	has_many :products, :dependent => :destroy
	has_many :transactions
	has_one :image, :as => :attachable, :dependent => :destroy

	def ensure_authentication_token!
		self.authentication_token = generate_authentication_token
		self.save
	end
	
private

	def generate_authentication_token
		loop do
			token = Devise.friendly_token
			break token unless User.where(:authentication_token => token).first
		end
	end
end
