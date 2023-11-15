require 'rails_helper'

RSpec.describe "Rentals", type: :system do
  describe 'Rentals CRUD functions' do
    before do
      @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
      @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
    end
    context 'When a admin tries to car a rental' do
      it 'will not work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        visit new_rental_path
        expect(current_path).to eq root_path
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
        visit car_path(@car)
        click_on 'Réserver'
        fill_in 'Date', with: '2023-11-12'
        fill_in 'Heure', with: '15:00:00'
        fill_in 'Nombre de jour', with: '1'
        fill_in 'Lieu', with: 'Mahina'
        click_on 'Réserve'
        expect(page).to have_content 'La réservation a été faite avec succès.'
      end
    end
    context 'When a user tries to cancel his rental' do
      before do
        @car = FactoryBot.create(:car)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        sleep(2)
        visit car_path(@car)
        click_on 'Réserver'
        click_on 'Annuler'
      end
    end
    context 'When an admin tries to edit a rental' do
      before do
        @rental = FactoryBot.create(:rental)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit rental_path(@rental.id)
        click_on 'Modifier rental'
        fill_in 'Date', with: '2023-11-15'
        fill_in 'Heure', with: '15:05:00'
        fill_in 'Nombre de jour', with: '2'
        fill_in 'Lieu', with: 'Kayes'
        click_on 'Modifier'
        expect(page).to have_content 'La réservation a été modifier avec succès.'
      end
    end
    context 'When an admin tries to destroy a parking' do
      before do
        @rental = FactoryBot.create(:rental)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit rental_path(@rental.id)
        click_on 'Supprimer'
        page.accept_confirm
        expect(page).to have_content 'La réservation a été supprimer avec succès.'
      end
    end
  end
end
