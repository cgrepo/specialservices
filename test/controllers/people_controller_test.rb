require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { address: @person.address, admission_date: @person.admission_date, age: @person.age, birth_date: @person.birth_date, civil_status: @person.civil_status, current_residence: @person.current_residence, kind: @person.kind, name: @person.name, occupation: @person.occupation, phone: @person.phone, relationship: @person.relationship, salary: @person.salary, scolarship: @person.scolarship, transportation: @person.transportation, workplace: @person.workplace }
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    patch :update, id: @person, person: { address: @person.address, admission_date: @person.admission_date, age: @person.age, birth_date: @person.birth_date, civil_status: @person.civil_status, current_residence: @person.current_residence, kind: @person.kind, name: @person.name, occupation: @person.occupation, phone: @person.phone, relationship: @person.relationship, salary: @person.salary, scolarship: @person.scolarship, transportation: @person.transportation, workplace: @person.workplace }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end
end
