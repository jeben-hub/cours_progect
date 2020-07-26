class ChaptersController < ApplicationController
  include ApplicationHelper
  skip_before_action :require_login, only: [:index, :show]
  skip_before_action :require_not_blocked, only: [:index, :show]
  skip_before_action :require_activate, only: [:index, :show]
  before_action :require_asses_to_chapters, except: [:index, :show, :sort]
  before_action :set_fanfic, except: [:sort]
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  def show
  end

  def sort
    params[:chapters_ids].split(",").each_with_index  do |chapter_id, index|
        Chapter.find(chapter_id).update_attribute("number", index + 1)
    end
  end

  def new
    @chapter = Chapter.new
  end

  def edit
  end

  def create
    @chapter = Chapter.new(chapter_params_to_save)
    @chapter.fanfic_id = params[:fanfic_id]
    @chapter.number = @fanfic.chapters.count + 1
    if @chapter.save
      render "show"
    else
      render "new"
    end
  end

  def update
    if @chapter.update(chapter_params_to_save)
      render :show
    else
      render :edit
    end
  end

  def destroy
    delete_exist_picture
    @chapter.destroy
    redirect_to @fanfic
  end

  private

    def chapter_params_to_save
      @image = params[:chapter][:picture]
      if @image.nil?
        return chapter_params
      else
        return upload_picture_chapter_params
      end
    end

    def upload_picture_chapter_params
      delete_exist_picture
      upload_rezult = Cloudinary::Uploader.upload(@image)
      chapter_params.merge(picture: upload_rezult['secure_url'])
    end

    def delete_exist_picture
      if @chapter.picture
        picture_id = @chapter.picture.split('/').last.split('.').first
        Cloudinary::Uploader.destroy(picture_id)
      end
    end

    def require_asses_to_chapters
      return if has_access?(Fanfic.find(params[:fanfic_id]).user_id)
      redirect_back_or_to root_path, alert: t("notice.access")
    end

    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    def set_fanfic
      @fanfic = Fanfic.find(params[:fanfic_id])
    end

    def chapter_params
      params.require(:chapter).permit(:name, :body, :picture)
    end
end
