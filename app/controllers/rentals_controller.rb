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
  end

  def show
  end

  def new
    @rental = Rental.new
  end

  def edit
    @rental = Rental.find(params[:id])
    @car = @rental.car
    @user = current_user
  end

  def create
    car_id = rental_params[:car_id]
    user_id = rental_params[:user_id]
    @rental = Rental.new(rental_params)
    @car = @rental.car
  
    if @rental.date < Time.current
      flash[:alert] = "La date de location ne peut pas être antérieure à la date et à l'heure actuelles."
      render :new
    else
      @car.update(disponible: false)
  
      if @rental.save
        @selected_chauffeur = Chauffeur.find_by(id: params[:rental][:chauffeur_id])
        flash[:notice] = 'La réservation a été faite avec succès.'
        redirect_to @rental
      else
        @error_message = @rental.errors.full_messages.join(', ')
        @car.update(disponible: true)
        render :new
      end
    end
  end

  def update
    @rental = Rental.find(params[:id])
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully updated." }
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
      format.html { redirect_to rentals_url, notice: "Rental was successfully destroyed." }
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
end
