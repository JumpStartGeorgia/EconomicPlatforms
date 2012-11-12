require 'test_helper'

class ActivityImagesControllerTest < ActionController::TestCase
  setup do
    @activity_image = activity_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activity_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activity_image" do
    assert_difference('ActivityImage.count') do
      post :create, activity_image: @activity_image.attributes
    end

    assert_redirected_to activity_image_path(assigns(:activity_image))
  end

  test "should show activity_image" do
    get :show, id: @activity_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activity_image.to_param
    assert_response :success
  end

  test "should update activity_image" do
    put :update, id: @activity_image.to_param, activity_image: @activity_image.attributes
    assert_redirected_to activity_image_path(assigns(:activity_image))
  end

  test "should destroy activity_image" do
    assert_difference('ActivityImage.count', -1) do
      delete :destroy, id: @activity_image.to_param
    end

    assert_redirected_to activity_images_path
  end
end
