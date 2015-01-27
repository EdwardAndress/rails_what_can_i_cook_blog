require 'rails_helper'

describe 'editing articles' do

	before do
		Article.create(title: 'original title', body: 'original body', published_at: Time.now)
		visit '/articles'
		expect(page).to have_content 'original title' && 'original body'
	end

	context 'can be done from the listing page' do

		it 'by clicking on the appropriate link' do
			expect(page).to have_link 'Edit'
		end

		it 'which takes the user to a form for editing' do
			click_link 'Edit'
			expect(page).to have_content "Editing 'original title'"
			expect(page).to have_button "Apply Changes"
		end

		it 'and the article attributes are updated' do
			click_link 'Edit'
			fill_in 'Title', with: 'Edited Title'
			fill_in 'Body', with: 'Edited body'
			click_on 'Apply Changes'
			expect(page).to have_content 'Edited Title'
			expect(page).to have_content 'Edited body'
		end

	end

end
