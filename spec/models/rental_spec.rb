require 'rails_helper'

RSpec.describe Rental, type: :model do
  before do
    @car = FactoryBot.create(:car)
    @chauffeur = FactoryBot.create(:chauffeur)
  end
  describe "Rental model functions" do
    context 'The rental date cannot be earlier than the current date.' do
      it "Validation fails" do
        rental = Rental.create(date: "2023-11-10", time: "15:00:00", duration: "1", destination: "Mahina", chauffeur_id: @chauffeur.id)
        expect(rental).to be_invalid
      end
    end
    context 'The rental time cannot be earlier than the current time.' do
      it "Validation fails" do
        rental = Rental.create(date: "2023-11-12", time: "14:59:00", duration: "1", destination: "Mahina", chauffeur_id: @chauffeur.id)
        expect(rental).to be_invalid
      end
    end
    context 'The rental date and time cannot be earlier than the current date and time.' do
      it "Validation fails" do
        rental = Rental.create(date: "2023-11-10", time: "14:59:00", duration: "1", destination: "Mahina", chauffeur_id: @chauffeur.id)
        expect(rental).to be_invalid
      end
    end
    context 'If duration is empty' do
      it "Validation fails" do
        rental = Rental.create(date: "2023-11-10", time: "14:59:00", duration: "", destination: "Mahina", chauffeur_id: @chauffeur.id)
        expect(rental).to be_invalid
      end
    end
    context 'If destination is empty' do
      it "Validation fails" do
        rental = Rental.create(date: "2023-11-12", time: "15:00:00", duration: "1", destination: "", chauffeur_id: @chauffeur.id)
        expect(rental).to be_invalid
      end
    end
    context 'The selected driver is already booked for a current reservation.' do
      it "Validation fails" do
        rental = Rental.create(date: "2023-11-12", time: "15:00:00", duration: "1", destination: "Mahina", chauffeur_id: @chauffeur[1])
        expect(rental).to be_invalid
      end
    end
    context 'If all contain value' do
      it "Validation succeeds" do
        rental = Rental.create(date: "2023-11-12", time: "15:00:00", duration: "1", destination: "Mahina", chauffeur_id: @chauffeur.id, user_id: @user.id, car_id: @car.id)
        expect(rental).to be_valid
      end
    end
  end
end
