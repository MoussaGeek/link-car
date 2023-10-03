class ParkingsController < ApplicationController
  before_action :set_parking, only: %i[ show edit update destroy ]

  # GET /parkings or /parkings.json
  def index
    @parkings = Parking.all
  end

  # GET /parkings/1 or /parkings/1.json
  def show
  end

  # GET /parkings/new
  def new
    @parking = Parking.new
  end

  # GET /parkings/1/edit
  def edit
  end

  # POST /parkings or /parkings.json
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

  # PATCH/PUT /parkings/1 or /parkings/1.json
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

  # DELETE /parkings/1 or /parkings/1.json
  def destroy
    @parkings = Parking.find(params[:id])
    @parking.destroy
    flash[:success] = 'parking deleted.'
    redirect_to parkings_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking
      @parking = Parking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parking_params
      params.require(:parking).permit(:name, :name_gerant, :email, :city)
    end
end
