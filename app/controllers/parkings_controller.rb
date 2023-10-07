class ParkingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parking, only: %i[ show edit update destroy ]

  def index
    @parkings = Parking.all
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

    respond_to do |format|
      if @parking.save
        format.html { redirect_to parking_url(@parking), notice: "Parking was successfully created." }
        format.json { render :show, status: :created, location: @parking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @parking.update(parking_params)
        format.html { redirect_to parking_url(@parking), notice: "Parking was successfully updated." }
        format.json { render :show, status: :ok, location: @parking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @parkings = Parking.find(params[:id])
    @parking.destroy
    flash[:success] = 'parking deleted.'
    redirect_to parkings_url
  end

  private
    def set_parking
      @parking = Parking.find(params[:id])
    end

    def parking_params
      params.require(:parking).permit(:name, :name_gerant, :email, :city)
    end
end
