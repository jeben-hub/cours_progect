class FanficsController < ApplicationController
  include ApplicationHelper
  before_action :set_fanfic, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]
  skip_before_action :require_not_blocked, only: [:index, :show]
  skip_before_action :require_activate, except: [:create, :new]
  before_action :require_asses_to_fanfics, except: [:index, :show]
  # GET /fanfics
  # GET /fanfics.json
  def index
    if @tag_name = params[:tag]
      @fanfics = Tag.find_by_name(@tag_name).fanfics.order(created_at: :desc)
    else
      @fanfics = Fanfic.order(created_at: :desc)
    end
  end

  # GET /fanfics/1
  # GET /fanfics/1.json
  def show
    @chapters = @fanfic.chapters
    @comments = @fanfic.comments.order(created_at: :desc)
  end

  # GET /fanfics/new
  def new
    @fanfic = Fanfic.new
    @user_id = params[:user_id]
  end

  # GET /fanfics/1/edit
  def edit
  end

  # POST /fanfics
  # POST /fanfics.json
  def create
    @fanfic = Fanfic.new(fanfic_params)
    @fanfic.user_id = params[:user_id]
    respond_to do |format|
      if @fanfic.save
        format.html { redirect_to @fanfic, notice: 'Fanfic was successfully created.' }
        format.json { render :show, status: :created, location: @fanfic }
      else
        format.html { render :new }
        format.json { render json: @fanfic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fanfics/1
  # PATCH/PUT /fanfics/1.json
  def update
    respond_to do |format|
      if @fanfic.update(fanfic_params)
        format.html { redirect_to @fanfic, notice: 'Fanfic was successfully updated.' }
        format.json { render :show, status: :ok, location: @fanfic }
      else
        format.html { render :edit }
        format.json { render json: @fanfic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fanfics/1
  # DELETE /fanfics/1.json
  def destroy
    @fanfic.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Fanfic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_fanfic
      @fanfic = Fanfic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fanfic_params
      params.require(:fanfic).permit(:title, :description, :genre_id, :all_tags)
    end

    def require_asses_to_fanfics
      expected_user_id = @fanfic ? @fanfic.author.id : params[:user_id].to_i
      return if has_access?(expected_user_id)
      redirect_back_or_to root_path, alert: 'You have no asses to do this'
    end

end
