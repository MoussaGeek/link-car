class ChauffeursController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chauffeur, only: %i[ show edit update destroy ]
  before_action :only_admin

  def index
    @chauffeurs = Chauffeur.all
    @total_chauffeurs = @chauffeurs.count
    @chauffeurs = Chauffeur.page(params[:page])
  end

  def show
  end

  def new
    @chauffeur = Chauffeur.new
  end

  def edit
  end

  def create
    @chauffeur = Chauffeur.new(chauffeur_params)
    if @chauffeur.save
      flash[:notice] = "Le chauffeur a été créé avec succès."
      redirect_to @chauffeur
    else
      @error_message = @chauffeur.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    respond_to do |format|
      if @chauffeur.update(chauffeur_params)
        format.html { redirect_to chauffeur_url(@chauffeur), notice: "Le parking a été modifier avec succès." }
        format.json { render :show, status: :ok, location: @chauffeur }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chauffeur.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @chauffeur.destroy
    respond_to do |format|
      format.html { redirect_to chauffeurs_url, notice: "Le chauffeur a été supprimer avec succès." }
      format.json { head :no_content }
    end
  end

  private
    def set_chauffeur
      @chauffeur = Chauffeur.find(params[:id])
    end

    def chauffeur_params
      params.require(:chauffeur).permit(:name, :telephone, :quartier, :parking_id, :photo_permis, :photo_carte)
    end

    def only_admin
      redirect_to root_path unless current_user&.admin?
    end
end
