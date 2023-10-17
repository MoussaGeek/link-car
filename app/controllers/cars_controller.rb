class CarsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_car, only: %i[ show edit update destroy ]
  before_action :only_admin, except: [:index, :show]


  def index
    @cars = Car.page(params[:page])
  end

  def show
  end
  
  def new
    @car = Car.new
  end

  def edit
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:notice] = "La voiture a été créer avec succès."
      redirect_to @car
    else
      @error_message = @car.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @car.update(car_params)
      flash[:notice] = 'La voiture a été modifier avec succès.'
      redirect_to @car
    else
      render :edit
    end
  end

  def destroy
    @car.destroy
    flash[:notice] = 'La voiture a été supprimer avec succès.'
      redirect_to cars_url
  end

  private

    def car_params
      params.require(:car).permit(:numero_matricule, :marque, :modele, :carburant, :price_rental, :disponible, :car_type, :annee, :parking_id, :photo)
    end

    def set_car
      @car = Car.find(params[:id])
    end

    def only_admin
      redirect_to root_path unless current_user&.admin?
    end
end
