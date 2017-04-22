require 'securerandom'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  attr_accessor :login

  before_create :set_auth_token

	validates :username, :presence => true, :uniqueness => { :case_sensitive => false	  } # etc.
	validate :validate_username

	has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sent_by_id'
	has_many :recieved_messages, :class_name => 'Message', :foreign_key => 'recieved_by_id'

	def validate_username
	  if User.where(email: username).exists?
	    errors.add(:username, :invalid)
	  end
	end

	def self.find_for_database_authentication(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
	    where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  elsif conditions.has_key?(:username) || conditions.has_key?(:email)
	    where(conditions.to_h).first
	  end
	end

  private
  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end

end
