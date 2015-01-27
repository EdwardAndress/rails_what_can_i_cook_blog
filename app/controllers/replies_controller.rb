class RepliesController < ApplicationController

before_action :load_article, except: :destroy
before_action :authenticate, only: :destroy

def new
	puts 'hello'
end

def create
	@reply = @article.replies.new(reply_params)
	if @reply.save
		respond_to do |format|	
			format.html { redirect_to @article, notice: 'Thanks for your reply' }
			format.js
		end
	else
		respond_to do |format|
			format.html { redirect_to @article, alert: 'Something went wrong!  We were unable to add your comment :(' }
			format.js	{ render 'fail_create.js.erb' }
		end
	end
end

def destroy
	@article = current_user.articles.find(params[:article_id])
	@reply = @article.replies.find(params[:id])
	@reply.destroy
	respond_to do |format|		
		format.html { redirect_to @article, notice: 'Reply deleted' }
		format.js
	end
end

private

def load_article
	@article = Article.find(params[:article_id])
end

def reply_params
	params.require(:reply).permit(:name, :email, :body)
end

end
