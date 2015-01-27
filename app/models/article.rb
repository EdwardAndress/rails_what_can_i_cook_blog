class Article < ActiveRecord::Base

	validates_presence_of :title
	validates_presence_of :body
	validates_presence_of :excerpt
	validates_presence_of :location

	has_and_belongs_to_many :ingredients
	belongs_to :user
	has_many :replies

	scope :published, lambda { where("articles.published_at IS NOT NULL")}
	scope :draft, lambda { where("articles.published_at IS NULL")}
	scope :recently_published, lambda { where("articles.published_at > ?",  1.week.ago.to_date )}
	scope :where_title, lambda { |search_term| where("articles.title LIKE ?", "%#{search_term}%") }

	def owned_by?(owner)
		return false unless owner.is_a?(User)
		return false unless user.is_a?(User)
		user.email == owner.email
	end

end
