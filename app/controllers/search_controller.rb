class SearchController < ApplicationController
  skip_before_action :require_login, only: [:search]
  skip_before_action :require_not_blocked, only: [:search]
  skip_before_action :require_activate, except: [:search]
  before_action :set_term
  before_action :force_json, only: [:tag_search]

  def search
    if @term.nil?
      @articles = []
    else
      @fanfics = search_all.uniq
    end
  end

  def tag_search
    tags_array = @term.split(", ")
    tags = Tag.where("name LIKE ?", "%#{tags_array.last}%").limit(5).map(&:name)
    tags_array.pop
    @tags = tags_array.empty? ? tags : tags.map { |teg| tags_array.join(", ") + ", " + teg }
  end

  private
  def force_json
   request.format = :json
  end

  def set_term
    @term = params[:term]
  end

  def search_all
    fanfic_search + comment_search + chapter_search + genre_search + user_search
  end

  def fanfic_search
    search_rezult = Fanfic.search @term
    search_rezult.to_a
  end

  def comment_search
    comments =  Comment.search @term
    comments.map(&:fanfic)
  end

  def chapter_search
    chapters =  Chapter.search @term
    chapters.map(&:fanfic)
  end

  def genre_search
    genres =  Genre.search @term
    temp = []
    genres.each {|genre| temp += genre.fanfics}
    temp
  end

  def user_search
    users =  User.search @term, fields: [:name]
    temp = []
    users.each {|user| temp += user.fanfics}
    temp
  end

end
