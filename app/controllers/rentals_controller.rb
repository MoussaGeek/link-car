class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rental, only: %i[ show edit update destroy ]

  # GET /rentals or /rentals.json
  def index
    authorize! :index, :rental
    @rentals = Rental.all
    @selected_chauffeur = Chauffeur.find_by(id: params[:chauffeur_id])
  end

  # GET /rentals/1 or /rentals/1.json
  def show
  end

  # GET /rentals/new
  def new
    @rental = Rental.new
  end
  # GET /rentals/1/edit
  def edit
    @rental = Rental.find(params[:id])
    @car = @rental.car
    @user = current_user
  end

  # POST /rentals or /rentals.json
  def create
    car_id = rental_params[:car_id]
    user_id = rental_params[:user_id]
    @rental = Rental.new(rental_params)
    @car = @rental.car
    @car.update(disponible: false)

    if @rental.save
      @selected_chauffeur = Chauffeur.find_by(id: params[:rental][:chauffeur_id])
      flash[:notice] = 'La reservation est fait avec succès.'
      redirect_to @rental
    else
      render :new
    end
  end

  # PATCH/PUT /rentals/1 or /rentals/1.json
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

  # DELETE /rentals/1 or /rentals/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rental_params
      params.require(:rental).permit(:date, :time, :duration, :destination, :car_id, :user_id, :chauffeur_id)
    end

end
