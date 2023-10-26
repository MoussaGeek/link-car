require 'rails_helper'

RSpec.describe "Cars", type: :system do
  describe 'Cars CRUD functions' do
    before do
      @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
      @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
    end
    context 'When a user tries to create a car' do
      it 'will not work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        visit new_car_path
        expect(current_path).to eq root_path
      end
    end
    context 'When an admin tries to create a car' do
      before do
        @parking = FactoryBot.create(:parking)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        click_on 'Voitures'
        click_on 'Créer une voiture'
        fill_in 'Numéro matricule', with: 'KL337DD'
        fill_in 'Marque', with: 'V8'
        fill_in 'Prix de Location', with: '25000'
        fill_in 'Modèle', with: 'Renault'
        fill_in 'Année de sorti', with: '2003'
        fill_in 'Carburant', with: 'Gasoil'
        fill_in 'Type de voiture', with: 'Voiture'
        attach_file 'Photo', Rails.root.join('spec', 'fixtures', 'test_image.jpg')
        select(@parking.name, from: 'Parking')
        click_on 'Créer'
        expect(page).to have_content 'La voiture a été créer avec succès.'
      end
    end
    context 'When an admin tries to edit a car' do
      before do
        @car = FactoryBot.create(:car)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit cars_path
        click_on 'Modifier'
        fill_in 'Numéro matricule', with: 'KL337DP'
        fill_in 'Marque', with: '4x4'
        fill_in 'Prix de Location', with: '27000'
        fill_in 'Modèle', with: 'Bougatti'
        fill_in 'Année de sorti', with: '2007'
        fill_in 'Carburant', with: 'Essence'
        fill_in 'Type de voiture', with: 'Camion'
        attach_file 'Photo', Rails.root.join('spec', 'fixtures', 'test_image.jpg')
        select(@parking.name, from: 'Nom_Parking')
        click_on 'Modifier la voiture'
        expect(page).to have_content 'La voiture a été modifier avec succès.'
      end
    end
    context 'When a user tries to car a rental' do
      before do
        @car = FactoryBot.create(:car)
        @chauffeur = FactoryBot.create(:chauffeur)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        click_on 'Voitures'
        click_on 'Show'
        click_on 'Rental'
        fill_in 'Date', with: 'V8'
        fill_in 'Time', with: '25000'
        fill_in 'Duration', with: '1'
        select(@chauffeur.name, from: 'Nom du chauffeur')
        click_on 'Submit'
        expect(page).to have_content 'La voiture a été réserver avec succès.'
      end
    end
    context 'When an admin tries to destroy a car' do
      before do
        @car = FactoryBot.create(:car)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit car_path(@car.id)
        click_on 'Supprimer'
        page.accept_confirm
        expect(page).to have_content 'La voiture a été supprimer avec succès.'
      end
    end
  end
end
