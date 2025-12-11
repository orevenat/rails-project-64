require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "#new" do
    @user = users(:one)
    sign_in @user

    get new_post_path
    assert_response :success
  end

  test "#new not authorized" do
    get new_post_path
    assert_response :redirect
  end

  test "#create" do
    @user = users(:one)
    sign_in @user

    attrs = {
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 80),
      category_id: categories(:ruby).id
    }

    post posts_path, params: { post: attrs }
    assert_response :redirect
    assert { Post.exists?(title: attrs[:title]) }
  end

  test "#create not authorized" do
    attrs = {
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 80),
      category_id: categories(:ruby).id
    }

    post posts_path, params: { post: attrs }
    assert_response :redirect
    assert { !Post.exists?(title: attrs[:title]) }
    assert { flash[:alert].present? }
  end
end
