require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'Registration function' do
    context 'when a user create an account' do
      it 'redirect to root path' do
        visit new_user_registration_path
        fill_in 'Nom', with: 'cedrik'
        fill_in 'Email', with: 'ceedrik@gmail.com'
        fill_in 'Mot de passe', with: '123456'
        fill_in 'Confirmation mot de passe', with: '123456'
        click_on 'S\'inscrire'
        expect(page).to have_content 'Bienvenue, vous êtes connecté.'
      end
    end
    context 'when a user tries to edit his profile' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        click_on 'Ma page'
        click_on 'Modifier mon profil'
        fill_in 'Nom', with: 'Jean'
        fill_in 'Mot de passe actuel', with: '123456'
        click_on 'Modifier'
        expect(page).to have_content 'Votre compte a été modifié avec succès.'
        click_on 'Ma page'
        expect(page).to have_content 'Jean'
      end
    end
    context 'when a user cancel his account' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'will work and redirect to root path' do
        visit new_user_session_path
        fill_in 'Email', with: 'ceedrik@gmail.com'
        fill_in 'Mot de passe', with: '123456'
        click_on 'Se connecter'
        click_on 'Ma page'
        click_on 'Modifier mon profil'
        click_on 'Annuler mon inscription'
        page.accept_confirm
        expect(page).to have_content 'Votre compte a été supprimé avec succès. Nous espérons vous revoir bientôt.'
      end
    end
  end
  describe 'Login function' do
    context 'when non logged-in user try to access to car page' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'is rejected and redirect to login page' do
        visit cars_path
        expect(page).to have_content 'Connexion'
      end
    end
    context 'when a existing user log in and log out' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'is successfully working' do
        visit new_user_session_path
        fill_in 'Email', with: 'ceedrik@gmail.com'
        fill_in 'Mot de passe', with: '123456'
        click_on 'Se connecter'
        expect(page).to have_content 'Connecté.'
        click_on 'Déconnexion'
        expect(page).to have_content 'Déconnecté.'
      end
    end
  end
  describe 'User access restriction' do
    context 'when user tries to access admin page' do
      before do
        @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'only admin user is able to access to admin dashboard' do
        visit new_user_session_path
        fill_in 'Email', with: 'ceedrik@gmail.com'
        fill_in 'Mot de passe', with: '123456'
        click_on 'Se connecter'
        expect(page).not_to have_content 'Panneau de contrôle'
        click_on 'Déconnexion'
        click_on 'Connexion'
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Mot de passe', with: 'password'
        click_on 'Se connecter'
        expect(page).to have_content 'Panneau de contrôle'
      end
    end
  end
  describe 'Admin privilege' do
    context 'when an admin tries to delete a user' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
        sleep(5)
        @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Mot de passe', with: 'password'
        click_on 'Se connecter'
        sleep(2)
        visit users_path
        sleep(2)
        click_on('Supprimer', match: :first)
        page.accept_confirm
        expect(page).to have_content 'L\'utilisateur a été supprimer avec succès.'
      end
    end
    context 'when an admin tries to modify a user' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
        sleep(5)
        @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Mot de passe', with: 'password'
        click_on 'Se connecter'
        sleep(2)
        visit users_path
        sleep(2)
        click_on('Modifier', match: :first)
        fill_in 'Mot de passe', with: '123456', visible: :all
        fill_in 'Confirmation mot de passe', with: '123456'
        check 'Admin'
        click_on 'Modifier'
        expect(page).to have_content 'L\'utilisateur a été modifier avec succès'
      end
    end
  end
end