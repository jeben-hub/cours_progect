class FanficsController < ApplicationController
  before_action :set_fanfic, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]

  # GET /fanfics
  # GET /fanfics.json
  def index
    @fanfics = Fanfic.all
  end

  # GET /fanfics/1
  # GET /fanfics/1.json
  def show
  end

  # GET /fanfics/new
  def new
    @fanfic = Fanfic.new
  end

  # GET /fanfics/1/edit
  def edit
  end

  # POST /fanfics
  # POST /fanfics.json
  def create
    @fanfic = Fanfic.new(fanfic_params)
    @fanfic.user_id = current_user.id

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
      format.html { redirect_to fanfics_url, notice: 'Fanfic was successfully destroyed.' }
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
      params.require(:fanfic).permit(:title, :description, :genre, :user_id)
    end

end
