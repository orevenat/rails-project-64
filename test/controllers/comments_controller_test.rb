require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "#create" do
    @user = users(:one)
    sign_in @user

    attrs = {
      content: Faker::Lorem.paragraph_by_chars(number: 80),
    }

    post = posts(:one)

    post post_comments_path(post), params: { post_comment: attrs }
    assert_response :redirect
    assert { PostComment.exists?(content: attrs[:content]) }
  end

  test "#create with parent_id" do
    @user = users(:one)
    sign_in @user

    post = posts(:one)
    comment = post_comments(:with_comments)

    attrs = {
      content: Faker::Lorem.paragraph_by_chars(number: 80),
      parent_id: comment.id
    }

    post post_comments_path(post), params: { post_comment: attrs }
    assert_response :redirect
    assert { PostComment.exists?(content: attrs[:content]) }
    assert { PostComment.find_by(content: attrs[:content]).ancestry == "/#{comment.id}/" }
  end

  test "#create with error" do
    @user = users(:one)
    sign_in @user

    attrs = {
      content: Faker::Lorem.paragraph_by_chars(number: 1),
    }

    post = posts(:one)

    post post_comments_path(post), params: { post_comment: attrs }
    assert_response :redirect
    assert { !PostComment.exists?(content: attrs[:content]) }
    assert { flash[:alert].present? }
  end

  test "#create not authorized" do
    attrs = {
      content: Faker::Lorem.paragraph_by_chars(number: 80),
    }

    post = posts(:one)

    post post_comments_path(post), params: { post_comment: attrs }
    assert_response :redirect
    assert { !PostComment.exists?(content: attrs[:content]) }
    assert { flash[:alert].present? }
  end
end
