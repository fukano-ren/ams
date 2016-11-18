require 'test_helper'

class BelongsControllerTest < ActionController::TestCase
  setup do
    @belong = belongs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:belongs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create belong" do
    assert_difference('Belong.count') do
      post :create, belong: { acquired_on: @belong.acquired_on, code: @belong.code, created_at: @belong.created_at, delete_flg: @belong.delete_flg, department_id: @belong.department_id, disponed_on: @belong.disponed_on, memo: @belong.memo, model: @belong.model, name: @belong.name, update_at: @belong.update_at, user_id: @belong.user_id }
    end

    assert_redirected_to belong_path(assigns(:belong))
  end

  test "should show belong" do
    get :show, id: @belong
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @belong
    assert_response :success
  end

  test "should update belong" do
    patch :update, id: @belong, belong: { acquired_on: @belong.acquired_on, code: @belong.code, created_at: @belong.created_at, delete_flg: @belong.delete_flg, department_id: @belong.department_id, disponed_on: @belong.disponed_on, memo: @belong.memo, model: @belong.model, name: @belong.name, update_at: @belong.update_at, user_id: @belong.user_id }
    assert_redirected_to belong_path(assigns(:belong))
  end

  test "should destroy belong" do
    assert_difference('Belong.count', -1) do
      delete :destroy, id: @belong
    end

    assert_redirected_to belongs_path
  end
end
