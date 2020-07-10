class SearchController < ApplicationController
  def search
    if params[:term].nil?
      @articles = []
    else
      @term = params[:term]
      @fanfics = search_all
    end
  end

  private

  def search_all
    fanfic_search + comment_search + chapter_search + genre_search + user_search
  end

  def fanfic_search
    search_rezult = Fanfic.search @term
    search_rezult.to_a
  end

  def comment_search
    search_rezult =  Comment.search @term
    search_rezult.map {|comment| comment.fanfic}
  end

  def chapter_search
    search_rezult =  Chapter.search @term
    search_rezult.map {|chapter| chapter.fanfic}
  end

  def genre_search
    search_rezult =  Genre.search @term
    temp = []
    search_rezult.each {|genre| temp += genre.fanfics}
    temp
  end

  def user_search
    search_rezult =  User.search @term, fields: [:name]
    temp = []
    search_rezult.each {|user| temp += user.fanfics}
    temp
  end
end
