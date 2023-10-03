require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @car = cars(:one)
  end

  test "visiting the index" do
    visit cars_url
    assert_selector "h1", text: "Cars"
  end

  test "creating a Car" do
    visit cars_url
    click_on "New Car"

    fill_in "Annee", with: @car.annee
    fill_in "Car type", with: @car.car_type
    fill_in "Carburant", with: @car.carburant
    check "Disponible" if @car.disponible
    fill_in "Marque", with: @car.marque
    fill_in "Modele", with: @car.modele
    fill_in "Numero matricule", with: @car.numero_matricule
    fill_in "Parking", with: @car.parking_id
    fill_in "Price rental", with: @car.price_rental
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "updating a Car" do
    visit cars_url
    click_on "Edit", match: :first

    fill_in "Annee", with: @car.annee
    fill_in "Car type", with: @car.car_type
    fill_in "Carburant", with: @car.carburant
    check "Disponible" if @car.disponible
    fill_in "Marque", with: @car.marque
    fill_in "Modele", with: @car.modele
    fill_in "Numero matricule", with: @car.numero_matricule
    fill_in "Parking", with: @car.parking_id
    fill_in "Price rental", with: @car.price_rental
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "destroying a Car" do
    visit cars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car was successfully destroyed"
  end
end
