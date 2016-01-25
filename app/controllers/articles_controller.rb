class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles
  end

  def create
    new_article = Article.create(url: params[:article][:url], user: current_user)
    redirect_to(articles_path, flash: { error: new_article.errors.full_messages.join(' ') })
  end

  def show
    @article = Article.find(params[:id])
  end
end
