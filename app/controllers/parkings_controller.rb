class ParkingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_parking, only: %i[ show edit update destroy ]
  before_action :only_admin, except: [:index, :show]

  def index
    @parkings_with_car_counts = Parking.joins(:cars).group('parkings.id').select('parkings.*, count(cars.id) as car_count')
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
    cars = @parking.cars
    cars.each do |car|
      car.rentals.destroy_all
    end
    @parking.cars.destroy_all
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

    def only_admin
      if current_user.nil? || !current_user.admin?
        redirect_to root_path
      end
    end
end
