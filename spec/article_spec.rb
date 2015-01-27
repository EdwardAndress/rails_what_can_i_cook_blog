require 'rails_helper'

describe 'articles' do

	before do
		@article = Article.new
	end

	context 'should have two attributes in order to be valid' do

		it 'title' do
			@article.body = 'text'
			expect(@article.save).to be false
		end

		it 'body' do
			@article.title = 'string'
			expect(@article.save).to be false
		end

		it 'and when both are present the article will save' do
			@article.title = 'string'
			@article.body = 'text'
			expect(@article.save).to be true
		end

		it 'this is how many articles now exist in the test database' do
			puts Article.count
		end

	end

end