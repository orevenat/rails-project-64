require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "#new" do
    get new_post_path
    assert_response :success
  end

  test "#create" do
    attrs = {
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph_by_chars(number: 80),
      category_id: categories(:ruby).id
    }

    post posts_path, params: { post: attrs }
    assert_response :redirect
    assert { Post.exists?(title: attrs[:title]) }
  end
end
