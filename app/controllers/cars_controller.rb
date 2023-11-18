class CarsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :only_admin, except: [:index, :show]

  def index
    @cars = Car.all
    @total_cars = @cars.count
    @total_cars_available = @cars.where(disponible: true).count

    if params[:numero_matricule].present?
      @cars = @cars.where("numero_matricule ILIKE ?", "%#{params[:numero_matricule]}%")
    end

    if params[:parking].present?
      @cars = @cars.where(parking_id: params[:parking])
    end

    if params[:modele].present?
      @cars = @cars.where("modele ILIKE ?", "%#{params[:modele]}%")
    end

    if params[:car_type].present?
      @cars = @cars.where("car_type ILIKE ?", "%#{params[:car_type]}%")
    end

    if params[:disponibilite] == 'disponible'
      @cars = @cars.where(disponible: true)
      @total_cars_available = @cars.count
    end

    @cars = @cars.page(params[:page])
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
      flash[:notice] = 'La voiture a été créée avec succès.'
      redirect_to @car
    else
      flash[:alert] = @car.errors[:numero_matricule].join(', ')
      render :new
    end
  end

  def update
    @car = Car.find(params[:id])

    if car_params[:numero_matricule] != @car.numero_matricule
      @car.rentals.destroy_all
      @car.update(disponible: true)
    end

    if @car.update(car_params)
      flash[:notice] = 'La voiture a été modifiée avec succès.'
      redirect_to @car
    else
      render :edit
    end
  end

  def destroy
    @car.destroy
    flash[:notice] = 'La voiture a été supprimée avec succès.'
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