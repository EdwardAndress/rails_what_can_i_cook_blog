class Reply < ActiveRecord::Base

	after_create :email_article_author

	belongs_to :article

	validates_presence_of :email
	validates_presence_of :name
	validates_presence_of :body

	private

	def email_article_author
		Notifier.comment_added(self).deliver
	end
	
end
