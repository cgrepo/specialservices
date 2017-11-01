require 'test_helper'

class OtherExpedituresControllerTest < ActionController::TestCase
  setup do
    @other_expediture = other_expeditures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:other_expeditures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create other_expediture" do
    assert_difference('OtherExpediture.count') do
      post :create, other_expediture: {  }
    end

    assert_redirected_to other_expediture_path(assigns(:other_expediture))
  end

  test "should show other_expediture" do
    get :show, id: @other_expediture
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @other_expediture
    assert_response :success
  end

  test "should update other_expediture" do
    patch :update, id: @other_expediture, other_expediture: {  }
    assert_redirected_to other_expediture_path(assigns(:other_expediture))
  end

  test "should destroy other_expediture" do
    assert_difference('OtherExpediture.count', -1) do
      delete :destroy, id: @other_expediture
    end

    assert_redirected_to other_expeditures_path
  end
end
