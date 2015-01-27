require 'rails_helper'

describe 'associating profiles with users' do

	context 'when a user signs up successfully' do

		it 'they should automatically be redirected to create a profile' do
			visit '/users/new'
			fill_in 'Email', with: 'anotheremail@email.com'
			fill_in 'Password', with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			fill_in 'Name', with: 'Eddie'
			click_on 'Create'
			expect(page).to have_content 'Biography'
		end

	end

end