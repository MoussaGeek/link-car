class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admin, only: [:new]
  before_action :set_rental, only: %i[ show edit update destroy ]

  def index
    authorize! :index, :rental
    @rentals = Rental.all
    @total_rentals = @rentals.count
    @rentals = Rental.page(params[:page])
    @selected_chauffeur = Chauffeur.find_by(id: params[:chauffeur_id])

    expire_reservations
  end

  def show
  end

  def edit
    @rental = Rental.find(params[:id])
    @car = @rental.car
    @user = current_user
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    @car = @rental.car
  
    # Si toutes les validations passent, mettez à jour la disponibilité du car et enregistrez la réservation
    if @rental.save
      @car.update(disponible: false)
      @selected_chauffeur = Chauffeur.find_by(id: params[:rental][:chauffeur_id])
      flash[:notice] = 'La réservation a été faite avec succès.'
      redirect_to @rental
    else
      flash[:alert] = "Erreur lors de la création de la réservation. Veuillez vérifier les champs du formulaire."
      @error_message = @rental.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @rental = Rental.find(params[:id]) 
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to rental_url(@rental), notice: "La réservation a été modifiée avec succès." }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rental.destroy
    @car = @rental.car
    @car.update(disponible: true)

    respond_to do |format|
      format.html { redirect_to rentals_url, notice: "La réservation a été supprimée avec succès." }
      format.json { head :no_content }
    end
  end

  private
    def set_rental
      @rental = Rental.find(params[:id])
    end

    def rental_params
      params.require(:rental).permit(:date, :time, :duration, :destination, :car_id, :user_id, :chauffeur_id)
    end

    def only_admin
      if current_user&.admin?
        flash[:alert] = "Accès refusé aux administrateurs."
        redirect_to root_path
      end
    end

    def expire_reservations
      Rental.active.each do |rental|
        if rental.expired?
          car = rental.car
          car.update(disponible: true)
          rental.destroy
        end
      end
    end

    def chauffeur_selected_for_active_reservation?
      chauffeur_id = rental_params[:chauffeur_id]
      return false unless chauffeur_id.present?
  
      # Vérifie si le chauffeur sélectionné a une réservation en cours
      active_reservation = Rental.where(chauffeur_id: chauffeur_id).active.first
      active_reservation.present?
    end
end