require 'rails_helper'

RSpec.describe Parking, type: :model do
  before do
    @parking = FactoryBot.create(:parking)
  end
  describe 'Parking model functions' do
    context 'If name is empty' do
      it 'Validation fails' do
        parking = Parking.create(name: "", name_gerant: "Kaou", email: "ceedrik@gmail.com", city: "Kayes",  latitude: "14.666", longitude: "-6.4555")
        expect(parking).to be_invalid
      end
    end
    context 'If name_gerant is empty' do
      it 'Validation fails' do
        parking = Parking.create(name: "Pantere", name_gerant: "", email: "ceedrik@gmail.com", city: "Kayes", latitude: "14.666", longitude: "-6.4555")
        expect(parking).to be_invalid
      end
    end
    context 'If city is empty' do
      it 'Validation fails' do
        parking = Parking.create(name: "Pantere", name_gerant: "Kaou", email: "ceedrik@gmail.com",  city: "", latitude: "14.666", longitude: "-6.4555")
        expect(parking).to be_invalid
      end
    end
    context 'If email is empty' do
      it 'Validation fails' do
        parking = Parking.create(name: "Pantere", name_gerant: "Kaou", email: "",  city: "Kayes", latitude: "14.666", longitude: "-6.4555")
        expect(parking).to be_invalid
      end
    end
    context 'If latutide is empty' do
      it 'Validation fails' do
        parking = Parking.create(name: "Pantere", name_gerant: "Kaou", email: "ceedrik@gmail.com",  city: "Kayes", latitude: "", longitude: "-6.4555")
        expect(parking).to be_invalid
      end
    end
    context 'If longitude is empty' do
      it 'Validation fails' do
        parking = Parking.create(name: "Pantere", name_gerant: "Kaou", email: "ceedrik@gmail.com",  city: "Kayes", latitude: "14.666", longitude: "")
        expect(parking).to be_invalid
      end
    end
    context 'If all contain value' do
      it 'Validation succeds' do
        parking = Parking.create(name: "Pantere", name_gerant: "Kaou",  email: "ceedrik@gmail.com",  city: "Kayes", latitude: "14.666", longitude: "-6.4555")
        expect(parking).to be_valid
      end
    end
  end 
end
