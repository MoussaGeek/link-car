require 'test_helper'

class ChauffeursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chauffeur = chauffeurs(:one)
  end

  test "should get index" do
    get chauffeurs_url
    assert_response :success
  end

  test "should get new" do
    get new_chauffeur_url
    assert_response :success
  end

  test "should create chauffeur" do
    assert_difference('Chauffeur.count') do
      post chauffeurs_url, params: { chauffeur: { name: @chauffeur.name, parking_id: @chauffeur.parking_id, quartier: @chauffeur.quartier, telephone: @chauffeur.telephone } }
    end

    assert_redirected_to chauffeur_url(Chauffeur.last)
  end

  test "should show chauffeur" do
    get chauffeur_url(@chauffeur)
    assert_response :success
  end

  test "should get edit" do
    get edit_chauffeur_url(@chauffeur)
    assert_response :success
  end

  test "should update chauffeur" do
    patch chauffeur_url(@chauffeur), params: { chauffeur: { name: @chauffeur.name, parking_id: @chauffeur.parking_id, quartier: @chauffeur.quartier, telephone: @chauffeur.telephone } }
    assert_redirected_to chauffeur_url(@chauffeur)
  end

  test "should destroy chauffeur" do
    assert_difference('Chauffeur.count', -1) do
      delete chauffeur_url(@chauffeur)
    end

    assert_redirected_to chauffeurs_url
  end
end
