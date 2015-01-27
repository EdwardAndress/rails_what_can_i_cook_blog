require 'rails_helper'

describe 'adding articles' do

	context 'from the index page' do
	
		it 'by clicking on "Contribute Article" ' do
			visit '/articles'
			expect(page).to have_content 'Contribute Article'
			click_link 'Contribute Article'
			['Title', 'Body'].each do |field_name|
				expect(page).to have_content field_name
			end
		end

		it 'causes them to be displayed at /articles ' do
			Article.create(title: 'string', body: 'text', published_at: Time.now)
			visit '/articles'
			['string','text'].each do |test_article_attribute|
				expect(page).to have_content test_article_attribute
			end
		end

	end

end