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
        fill_in 'Nom du chauffeur', with: 'John'
        fill_in 'Quartier', with: 'Kondjili'
        fill_in 'Télephone', with: '12345678'
        select(@parking.name, from: 'Nom du Parking')
        attach_file 'Permis de conduire', Rails.root.join('spec', 'fixtures', 'permis.jpg')
        attach_file 'Carte d\'identité', Rails.root.join('spec', 'fixtures', 'carte.jpg')
        click_on 'Créer'
        expect(page).to have_content 'Le chauffeur a été créé avec succès.'
      end
    end
    context 'When an admin tries to edit a chauffeur' do
      before do
        @parking = FactoryBot.create(:parking)
        @chauffeur = FactoryBot.create(:chauffeur)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit chauffeur_path(@chauffeur.id)
        click_on 'Modifier chauffeur'
        fill_in 'Nom du chauffeur', with: 'Jean'
        fill_in 'Quartier', with: 'Koulikoro'
        fill_in 'Télephone', with: '12345679'
        attach_file 'Permis de conduire', Rails.root.join('spec', 'fixtures', 'permis.jpg')
        attach_file 'Carte d\'identité', Rails.root.join('spec', 'fixtures', 'carte.jpg')
        click_on 'Modifier'
        expect(page).to have_content 'Le parking a été modifier avec succès.'
      end
    end
    context 'When an admin tries to destroy a chauffeur' do
      before do
        @parking = FactoryBot.create(:parking)
        @chauffeur = FactoryBot.create(:chauffeur)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit chauffeur_path(@chauffeur.id)
        click_on 'Supprimer'
        page.accept_confirm
        expect(page).to have_content 'Le chauffeur a été supprimer avec succès.'
      end
    end
  end
end
