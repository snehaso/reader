class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles
  end
end
