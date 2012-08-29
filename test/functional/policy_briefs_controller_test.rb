require 'test_helper'

class PolicyBriefsControllerTest < ActionController::TestCase
  setup do
    @policy_brief = policy_briefs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:policy_briefs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create policy_brief" do
    assert_difference('PolicyBrief.count') do
      post :create, policy_brief: @policy_brief.attributes
    end

    assert_redirected_to policy_brief_path(assigns(:policy_brief))
  end

  test "should show policy_brief" do
    get :show, id: @policy_brief.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @policy_brief.to_param
    assert_response :success
  end

  test "should update policy_brief" do
    put :update, id: @policy_brief.to_param, policy_brief: @policy_brief.attributes
    assert_redirected_to policy_brief_path(assigns(:policy_brief))
  end

  test "should destroy policy_brief" do
    assert_difference('PolicyBrief.count', -1) do
      delete :destroy, id: @policy_brief.to_param
    end

    assert_redirected_to policy_briefs_path
  end
end
