# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  def index
    @articles = if params[:category] and params[:category] != '' and category = Category.find(params[:category])
                  category.articles
                else
                  Article
                end

    if params[:date] and params[:date]!=''
      date = Date.new(params[:date].split('-')[1].to_i, params[:date].split('-')[0].to_i, 1)
      @articles = @articles.where(date:  date.beginning_of_month .. date.end_of_month)
      logger.info 'ddddddddddddddddddddddddddddddddddddddddddddd'
    end

    @articles = @articles.page params[:page]

    @page = Page.purpose('/news').first
  end

  def show
    @article = Article.find(params[:id])
  end
end
