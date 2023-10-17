require 'rails_helper'

RSpec.describe Car, type: :model do
  before do
    @parking = FactoryBot.create(:parking)
  end
  describe 'Car model functions' do
    context 'If numero_matricule is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "", marque: "V8", price_rental: "25000", modele: "Renault", annee: "2003", carburant: "Gasoil", car_type: "Voiture", parking_id: @parking.id)
        expect(car).to be_invalid
      end
    end
    context 'If marque is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "ABC1", marque: "", price_rental: "25000", modele: "Renault", annee: "2003", carburant: "Gasoil", car_type: "Voiture", parking_id: @parking.id)
        expect(car).to be_invalid
      end
    end
    context 'If price_rental is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "ABC1", marque: "V8", price_rental: "", modele: "Renault", annee: "2003", carburant: "Gasoil", car_type: "Voiture", parking_id: @parking.id)
        expect(car).to be_invalid
      end
    end
    context 'If modele is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "ABC1", marque: "V8", price_rental: "25000", modele: "", annee: "2003", carburant: "Gasoil", car_type: "Voiture", parking_id: @parking.id)
        expect(car).to be_invalid
      end
    end
    context 'If annee is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "ABC1", marque: "V8", price_rental: "25000", modele: "Renault", annee: "", carburant: "Gasoil", car_type: "Voiture", parking_id: @parking.id)
        expect(car).to be_invalid
      end
    end
    context 'If carburant is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "ABC1", marque: "V8", price_rental: "25000", modele: "Renault", annee: "2003", carburant: "", car_type: "Voiture", parking_id: @parking.id)
        expect(car).to be_invalid
      end
    end
    context 'If car_type is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "ABC1", marque: "V8", price_rental: "25000", modele: "Renault", annee: "2003", carburant: "Gasoil", car_type: "", parking_id: @parking.id)
        expect(car).to be_invalid
      end
    end
    context 'If parking_id is empty' do
      it 'Validation fails' do
        car = Car.create(numero_matricule: "ABC1", marque: "V8", price_rental: "25000", modele: "Renault", annee: "2003", carburant: "Gasoil", car_type: "Voiture", parking_id: "")
        expect(car).to be_invalid
      end
    end
    context 'If all contain value' do
      it 'Validation succeds' do
        car = Car.create(numero_matricule: "ABC1", marque: "V8", price_rental: "25000", modele: "Renault", annee: "2003", carburant: "Gasoil", car_type: "Voiture", parking_id: @parking.id)
        expect(car).to be_valid
      end
    end
  end 
end
