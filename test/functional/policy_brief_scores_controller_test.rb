require 'test_helper'

class PolicyBriefScoresControllerTest < ActionController::TestCase
  setup do
    @policy_brief_score = policy_brief_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:policy_brief_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create policy_brief_score" do
    assert_difference('PolicyBriefScore.count') do
      post :create, policy_brief_score: @policy_brief_score.attributes
    end

    assert_redirected_to policy_brief_score_path(assigns(:policy_brief_score))
  end

  test "should show policy_brief_score" do
    get :show, id: @policy_brief_score.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @policy_brief_score.to_param
    assert_response :success
  end

  test "should update policy_brief_score" do
    put :update, id: @policy_brief_score.to_param, policy_brief_score: @policy_brief_score.attributes
    assert_redirected_to policy_brief_score_path(assigns(:policy_brief_score))
  end

  test "should destroy policy_brief_score" do
    assert_difference('PolicyBriefScore.count', -1) do
      delete :destroy, id: @policy_brief_score.to_param
    end

    assert_redirected_to policy_brief_scores_path
  end
end
