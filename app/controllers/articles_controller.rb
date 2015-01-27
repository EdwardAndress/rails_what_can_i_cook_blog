class ArticlesController < ApplicationController
  before_action :authenticate, except: [:show, :index]
  before_action :set_article, only: [:show]
  before_action :check_for_cancel, only: [:create, :update]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  def notify_friend
    @article = Article.find(params[:id])
    Notifier.email_friend(@article, params[:name], params[:email]).deliver
    redirect_to @article, notice: "Email sent successfully"
  end

  # GET /articles/new
  def new
    @confirm_button = 'Create Article'
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
    @confirm_button = 'Apply Changes'
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)
    ingredients_from_form = params["article"]["ingredients"]["ingredient_names"].split(",")
    @article.ingredients = ingredients_from_form.map {|ingredient| Ingredient.find_or_create_by(name: ingredient)}
    @article.published_at = Time.now

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = current_user.articles.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = current_user.articles.find(params[:id])
    @title = @article.title
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "The article titled '#{@title}' was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :location, :excerpt)
    end

    def check_for_cancel
      if params[:commit] == 'Cancel'
        redirect_to articles_path
      end
    end

end
