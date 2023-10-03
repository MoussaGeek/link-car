require "application_system_test_case"

class ChauffeursTest < ApplicationSystemTestCase
  setup do
    @chauffeur = chauffeurs(:one)
  end

  test "visiting the index" do
    visit chauffeurs_url
    assert_selector "h1", text: "Chauffeurs"
  end

  test "creating a Chauffeur" do
    visit chauffeurs_url
    click_on "New Chauffeur"

    fill_in "Name", with: @chauffeur.name
    fill_in "Parking", with: @chauffeur.parking_id
    fill_in "Quartier", with: @chauffeur.quartier
    fill_in "Telephone", with: @chauffeur.telephone
    click_on "Create Chauffeur"

    assert_text "Chauffeur was successfully created"
    click_on "Back"
  end

  test "updating a Chauffeur" do
    visit chauffeurs_url
    click_on "Edit", match: :first

    fill_in "Name", with: @chauffeur.name
    fill_in "Parking", with: @chauffeur.parking_id
    fill_in "Quartier", with: @chauffeur.quartier
    fill_in "Telephone", with: @chauffeur.telephone
    click_on "Update Chauffeur"

    assert_text "Chauffeur was successfully updated"
    click_on "Back"
  end

  test "destroying a Chauffeur" do
    visit chauffeurs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Chauffeur was successfully destroyed"
  end
end
