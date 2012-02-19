require 'test_helper'

class ShowerVisitsControllerTest < ActionController::TestCase
  setup do
    @shower_visit = shower_visits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shower_visits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shower_visit" do
    assert_difference('ShowerVisit.count') do
      post :create, shower_visit: @shower_visit.attributes
    end

    assert_redirected_to shower_visit_path(assigns(:shower_visit))
  end

  test "should show shower_visit" do
    get :show, id: @shower_visit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shower_visit
    assert_response :success
  end

  test "should update shower_visit" do
    put :update, id: @shower_visit, shower_visit: @shower_visit.attributes
    assert_redirected_to shower_visit_path(assigns(:shower_visit))
  end

  test "should destroy shower_visit" do
    assert_difference('ShowerVisit.count', -1) do
      delete :destroy, id: @shower_visit
    end

    assert_redirected_to shower_visits_path
  end
end
