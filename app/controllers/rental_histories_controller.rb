class RentalHistoriesController < ApplicationController
    def index
        @rental_histories = RentalHistory.page(params[:page])
    end
    
    def by_car
        @car = Car.find(params[:car_id])
        @rental_histories = RentalHistory.where(car_matricule: @car.numero_matricule).page(params[:page])
    end
    
    def by_parking
        @parking = Parking.find(params[:parking_id])
        @rental_histories = RentalHistory.where(parking_id: @parking.id).page(params[:page])
    end
    
end
