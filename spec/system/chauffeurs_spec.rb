require 'rails_helper'

RSpec.describe "Chauffeurs", type: :system do
  describe 'Chauffeurs CRUD functions' do
    before do
      @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
      @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
    end
    context 'When a user tries to create a chauffeur' do
      it 'will not work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        visit new_chauffeur_path
        expect(current_path).to eq root_path
      end
    end
    context 'When an admin tries to create a chauffeur' do
      before do
        @parking = FactoryBot.create(:parking)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        click_on 'Chauffeurs'
        click_on 'Créer un chauffeur'
        fill_in 'Nom du chauffeur', with: 'Madou'
        fill_in 'Nom du gérant', with: 'Fily'
        fill_in 'Ville', with: 'Kayes'
        fill_in 'Email', with: 'ceedrik@gmail.com'
        fill_in 'Latitude', with: '14.666'
        fill_in 'Longitude', with: '-6.4555'
        click_on 'Créer'
        expect(page).to have_content 'Le parking a été créer avec succès.'
      end
    end
    context 'When an admin tries to edit a parking' do
      before do
        @parking = FactoryBot.create(:parking)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit parking_path(@parking.id)
        click_on 'Modifier'
        fill_in 'Nom du parking', with: 'Panne'
        fill_in 'Nom du gérant', with: 'Kaka'
        fill_in 'Ville', with: 'Koulikoro'
        fill_in 'Email', with: 'look@gmail.com'
        fill_in 'Latitude', with: '12.86273'
        fill_in 'Longitude', with: '-7.55985'
        click_on 'Modifier le parking'
        expect(page).to have_content 'Le parking a été modifier avec succès.'
      end
    end
    context 'When an admin tries to destroy a parking' do
      before do
        @parking = FactoryBot.create(:parking)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit parking_path(@parking.id)
        click_on 'Supprimer'
        page.accept_confirm
        expect(page).to have_content 'Le parking a été supprimer avec succès.'
      end
    end
  end
end
