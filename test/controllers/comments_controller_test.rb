require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
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
