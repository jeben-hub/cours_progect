class ChaptersController < ApplicationController
  include ApplicationHelper
  skip_before_action :require_login, only: [:index, :show]
  skip_before_action :require_not_blocked, only: [:index, :show]
  skip_before_action :require_activate, only: [:index, :show]
  before_action :require_asses_to_chapters, except: [:index, :show]
  before_action :set_fanfic
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  #def index
  #  @chapters = @fanfic.chapters.order(created_at: :desc)
  #end
  # GET /chapters/1
  # GET /chapters/1.json
  def show
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(chapter_params_to_save)
    @chapter.fanfic_id = params[:fanfic_id]
    @chapter.number = @fanfic.chapters.count + 1
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to fanfic_chapter_path(@fanfic, @chapter), notice: 'Chapter was successfully created.' }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params_to_save)
        format.html { redirect_to fanfic_chapter_path(@fanfic, @chapter), notice: 'Chapter was successfully updated.' }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
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
      if @chapter
        picture_id = @chapter.picture.split('/').last.split('.').first
        Cloudinary::Uploader.destroy(picture_id)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def require_asses_to_chapters
      return if has_access?(Fanfic.find(params[:fanfic_id]).user_id)
      redirect_back_or_to root_path, alert: 'You have no asses to do this'
    end

    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    def set_fanfic
      @fanfic = Fanfic.find(params[:fanfic_id])
    end

    # Only allow a list of trusted parameters through.
    def chapter_params
      params.require(:chapter).permit(:name, :body, :picture)
    end
end
