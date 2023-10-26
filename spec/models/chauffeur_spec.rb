require 'rails_helper'

RSpec.describe Chauffeur, type: :model do
  before do
    @parking = FactoryBot.create(:parking)
  end
  describe 'Chauffeur model functions' do
    context 'If name is empty' do
      it 'Validation fails' do
        chauffeur = Chauffeur.create(name: "", quartier: "Kondjili", parking_id: @parking.id, telephone: "12345678" )
        expect(chauffeur).to be_invalid
      end
    end
    context 'If telephone is empty' do
      it 'Validation fails' do
        chauffeur = Chauffeur.create(name: "John Doe", quartier: "Kondjili", parking_id: @parking.id, telephone: "")
        expect(chauffeur).to be_invalid
      end
    end
    context 'If quartier is empty' do
      it 'Validation fails' do
        chauffeur = Chauffeur.create(name: "John Doe", telephone: "12345678", quartier: "", parking_id: @parking.id)
        expect(chauffeur).to be_invalid
      end
    end
    context 'If parking is empty' do
      it 'Validation fails' do
        chauffeur = Chauffeur.create(name: "John Doe", telephone: "12345678", quartier: "Kondjili", parking_id: "")
        expect(chauffeur).to be_invalid
      end
    end
    context 'If all contain value' do
      it 'Validation succeds' do
        chauffeur = Chauffeur.create(name: "John Doe", telephone: "12345678", quartier: "Kondjili", parking_id: @parking.id)
        expect(chauffeur).to be_valid
      end
    end
  end 
end
