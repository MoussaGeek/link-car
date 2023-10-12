require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User model functions' do
    context 'If name is empty' do
      it 'Validation fails' do
        user = User.create(name: "", email: "admin@gmail.com", password: "sample", admin: true)
        expect(user).to be_invalid
      end
    end

    context 'If email is empty' do
      it 'Validation fails' do
        user = User.create(name: "cedrik", email: "", password: "sample", admin: false)
        expect(user).to be_invalid
      end
    end


    context 'If password length is less than 6' do
      it 'Validation fails' do
        user = User.create(name: "admin", email: "admin@gmail.com", password: "admin", admin: true)
        expect(user).to be_invalid
      end
    end

    context 'If the same email has already been used' do
      it 'Validation fails' do
        first_user = User.create(name: "First_User", email: "abc@gmail.com", password: "abcdefg", admin: false)
        expect(first_user).to be_valid
        second_user = User.create(name: "Second_User", email: "abc@gmail.com", password: "abcdefg", admin: false)
        expect(second_user).to be_invalid
      end
    end

    context 'If everything is inputted successfully' do
      it 'Validation succeeds in' do
        user = User.create(name: "admin", email: "admin@gmail.com", password: "adminadmin", admin: true)
        expect(user).to be_valid
      end
    end
  end
end