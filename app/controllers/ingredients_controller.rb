class IngredientsController < ApplicationController
	before_action :set_article

def edit
	@article.ingredients.delete(Ingredient.find(params[:id]))
	redirect_to @article
end

private

def set_article
	@article = Article.find(params[:article_id])
end

end
