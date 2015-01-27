require 'rails_helper'

describe 'when navigating through the site' do

	before do
		Article.create(title: 'string', body: 'text', published_at: Time.now)
		visit '/articles'
	end

	context 'on the page that lists all articles' do


		it 'there should be a "view" link for each article' do
			expect(page).to have_link 'View'
		end

	end

	context 'on the view article page' do

		it 'there should be a link to delete the article to save navigating back to listings' do
			click_link 'View'
			expect(page).to have_link 'Remove'
		end

	end

	context 'on the editing page' do

		it 'there should be a "cancel" button' do
			click_link 'Edit'
			expect(page).to have_button 'Cancel'
		end

		it 'there should not be a link called "Back"' do
			click_link 'Edit'
			expect(page).not_to have_link 'Back'
		end

	end

end