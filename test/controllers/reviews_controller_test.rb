require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, review: { comment: @review.comment, movie_id: @review.movie_id, user_id: @review.user_id }
    end

    assert_redirected_to review_path(assigns(:review))
  end

  test "should update review" do
    patch :update, id: @review, review: { comment: @review.comment, movie_id: @review.movie_id, user_id: @review.user_id }
    assert_redirected_to review_path(assigns(:review))
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete :destroy, id: @review
    end

    assert_redirected_to reviews_path
  end
end
