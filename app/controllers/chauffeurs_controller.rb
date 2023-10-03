class ChauffeursController < ApplicationController
  before_action :set_chauffeur, only: %i[ show edit update destroy ]

  # GET /chauffeurs or /chauffeurs.json
  def index
    @chauffeurs = Chauffeur.all
  end

  # GET /chauffeurs/1 or /chauffeurs/1.json
  def show
  end

  # GET /chauffeurs/new
  def new
    @chauffeur = Chauffeur.new
  end

  # GET /chauffeurs/1/edit
  def edit
  end

  # POST /chauffeurs or /chauffeurs.json
  def create
    @chauffeur = Chauffeur.new(chauffeur_params)

    respond_to do |format|
      if @chauffeur.save
        format.html { redirect_to chauffeur_url(@chauffeur), notice: "Chauffeur was successfully created." }
        format.json { render :show, status: :created, location: @chauffeur }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chauffeur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chauffeurs/1 or /chauffeurs/1.json
  def update
    respond_to do |format|
      if @chauffeur.update(chauffeur_params)
        format.html { redirect_to chauffeur_url(@chauffeur), notice: "Chauffeur was successfully updated." }
        format.json { render :show, status: :ok, location: @chauffeur }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chauffeur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chauffeurs/1 or /chauffeurs/1.json
  def destroy
    @chauffeur.destroy

    respond_to do |format|
      format.html { redirect_to chauffeurs_url, notice: "Chauffeur was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chauffeur
      @chauffeur = Chauffeur.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chauffeur_params
      params.require(:chauffeur).permit(:name, :telephone, :quartier, :parking_id)
    end
end
