class LemmasController < ApplicationController
  before_action :set_lemma, only: %i[ show edit update destroy ]

  # GET /lemmas or /lemmas.json
  def index
    @lemmas = Lemma.all
  end

  # GET /lemmas/1 or /lemmas/1.json
  def show
  end

  # GET /lemmas/new
  def new
    @lemma = Lemma.new
  end

  # GET /lemmas/1/edit
  def edit
  end

  # POST /lemmas or /lemmas.json
  def create
    @lemma = Lemma.new(lemma_params)

    respond_to do |format|
      if @lemma.save
        format.html { redirect_to lemma_url(@lemma), notice: "Lemma was successfully created." }
        format.json { render :show, status: :created, location: @lemma }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lemma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lemmas/1 or /lemmas/1.json
  def update
    respond_to do |format|
      if @lemma.update(lemma_params)
        format.html { redirect_to lemma_url(@lemma), notice: "Lemma was successfully updated." }
        format.json { render :show, status: :ok, location: @lemma }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lemma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lemmas/1 or /lemmas/1.json
  def destroy
    @lemma.destroy

    respond_to do |format|
      format.html { redirect_to lemmas_url, notice: "Lemma was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lemma
      @lemma = Lemma.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lemma_params
      params.require(:lemma).permit(:name, :type, :audio, :word_id)
    end
end
