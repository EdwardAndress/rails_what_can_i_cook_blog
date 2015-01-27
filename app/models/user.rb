
class User < ActiveRecord::Base
require 'digest'

	has_many :articles, -> { order('published_at DESC, title ASC')}, dependent: :nullify
	has_one :profile
	has_many :replies, through: :articles

	validates_uniqueness_of :email
	validates_length_of :email, within: 5..50

	validates_length_of :password, minimum: 8
	validates_confirmation_of :password

	attr_accessor :password

	before_save :encrypt_new_password
	after_save :clear_password

	def self.authenticate(email, password)
		user = User.find_by_email(email)
		return user if user && user.authenticated?(password)
	end

	def authenticated?(password)
		self.hashed_password == Digest::SHA1.hexdigest(password)
	end

	protected

	def encrypt_new_password
		return if password.blank?
		self.hashed_password = encrypt(password)
	end

	def encrypt(string)
		Digest::SHA1.hexdigest(string)
	end

	def clear_password
		@password = nil
	end

end
