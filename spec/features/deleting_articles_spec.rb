require 'rails_helper'

describe 'deleting articles' do

	context 'can be done from the listing page' do

		before(:each) do
			Article.create(title: 'delete me', body: 'now please', published_at: Time.now)
			visit '/articles'
			expect(page).to have_content 'delete me' && 'now please'
		end

		it 'by cliking on the appropriate link' do
			click_link 'Remove'
			expect(page).not_to have_content 'now please'
		end

		it 'and is confirmed to the user by a message displayed on screen' do
			click_link 'Remove'
			expect(page).to have_content "The article titled 'delete me' was successfully deleted"
		end

	end

end
