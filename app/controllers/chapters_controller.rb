class ChaptersController < ApplicationController
  include ApplicationHelper
  skip_before_action :require_login, only: [:index, :show]
  skip_before_action :require_not_blocked, only: [:index, :show]
  skip_before_action :require_activate, only: [:index, :show]
  before_action :require_asses_to_chapters, except: [:index, :show]
  before_action :set_fanfic
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  def index
    @chapters = @fanfic.chapters.order(created_at: :desc)
  end
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
    @chapter = Chapter.new(chapter_params)

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
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
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
    @chapter.destroy
    redirect_to @fanfic
  end

  private
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
      params.permit(:name, :body, :number, :fanfic_id)
    end
end
