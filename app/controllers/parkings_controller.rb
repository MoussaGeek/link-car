class ParkingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parking, only: %i[ show edit update destroy ]

  def index
    @parkings = Parking.page(params[:page])
  end

  def show
  end

  def new
    @parking = Parking.new
  end

  def edit
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      flash[:notice] = 'Le parking a été créer avec succès.'
      redirect_to @parking
    else
      @error_message = @parking.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    @parking = Parking.find(params[:id])
    if @parking.update(parking_params)
      flash[:notice] = 'Le parking a été modifier avec succès.'
      redirect_to @parking
    else
      @error_message = @parking.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @parking = Parking.find(params[:id])
    
    # Supprimer toutes les locations liées aux voitures de ce parking
    cars = @parking.cars
    cars.each do |car|
      car.rentals.destroy_all
    end
  
    # Supprimer toutes les voitures du parking
    @parking.cars.destroy_all
    
    # Supprimer le parking lui-même
    @parking.destroy
  
    redirect_to parkings_url, notice: "Le parking a été supprimé avec succès."
  end

  private
    def set_parking
      @parking = Parking.find(params[:id])
    end

    def parking_params
        params.require(:parking).permit(:name, :name_gerant, :email, :city, :latitude, :longitude)
    end
end
