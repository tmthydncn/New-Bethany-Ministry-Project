require 'test_helper'

class FoodVisitsControllerTest < ActionController::TestCase
  setup do
    @food_visit = food_visits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_visits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_visit" do
    assert_difference('FoodVisit.count') do
      post :create, food_visit: @food_visit.attributes
    end

    assert_redirected_to food_visit_path(assigns(:food_visit))
  end

  test "should show food_visit" do
    get :show, id: @food_visit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_visit
    assert_response :success
  end

  test "should update food_visit" do
    put :update, id: @food_visit, food_visit: @food_visit.attributes
    assert_redirected_to food_visit_path(assigns(:food_visit))
  end

  test "should destroy food_visit" do
    assert_difference('FoodVisit.count', -1) do
      delete :destroy, id: @food_visit
    end

    assert_redirected_to food_visits_path
  end
end
