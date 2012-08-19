require 'test_helper'

class StatementScoresControllerTest < ActionController::TestCase
  setup do
    @statement_score = statement_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statement_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statement_score" do
    assert_difference('StatementScore.count') do
      post :create, statement_score: @statement_score.attributes
    end

    assert_redirected_to statement_score_path(assigns(:statement_score))
  end

  test "should show statement_score" do
    get :show, id: @statement_score.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statement_score.to_param
    assert_response :success
  end

  test "should update statement_score" do
    put :update, id: @statement_score.to_param, statement_score: @statement_score.attributes
    assert_redirected_to statement_score_path(assigns(:statement_score))
  end

  test "should destroy statement_score" do
    assert_difference('StatementScore.count', -1) do
      delete :destroy, id: @statement_score.to_param
    end

    assert_redirected_to statement_scores_path
  end
end
