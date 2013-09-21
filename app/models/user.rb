class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
		 :token_authenticatable

  has_many :products, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
end
