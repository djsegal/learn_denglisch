class SagasController < ApplicationController
  before_action :set_saga, only: %i[ show edit update destroy ]

  # GET /sagas or /sagas.json
  def index
    redirect_to Saga.first
    # @sagas = Saga.all
  end

  # GET /sagas/1 or /sagas/1.json
  def show
    @videos = @saga.videos
    @max_seasons = @videos.map(&:season_number).max || -1
  end

  # GET /sagas/new
  def new
    @saga = Saga.new
  end

  # GET /sagas/1/edit
  def edit
  end

  # POST /sagas or /sagas.json
  def create
    @saga = Saga.new(saga_params)

    respond_to do |format|
      if @saga.save
        format.html { redirect_to saga_url(@saga), notice: "Saga was successfully created." }
        format.json { render :show, status: :created, location: @saga }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @saga.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sagas/1 or /sagas/1.json
  def update
    respond_to do |format|
      if @saga.update(saga_params)
        format.html { redirect_to saga_url(@saga), notice: "Saga was successfully updated." }
        format.json { render :show, status: :ok, location: @saga }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @saga.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sagas/1 or /sagas/1.json
  def destroy
    @saga.destroy

    respond_to do |format|
      format.html { redirect_to sagas_url, notice: "Saga was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saga
      @saga = Saga.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def saga_params
      params.require(:saga).permit(:name)
    end
end
