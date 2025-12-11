# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test '#create' do
    @user = users(:two)
    sign_in @user

    post = posts(:one)
    post post_likes_path(post)
    assert_response :redirect
    assert { PostLike.exists?(creator_id: @user.id) }
  end

  test '#create not authorized' do
    post = posts(:one)
    post post_likes_path(post)
    assert_response :redirect
    assert { flash[:alert].present? }
  end

  test '#destroy' do
    @user = users(:one)
    sign_in @user

    like = post_likes(:one)

    delete post_like_path(like.post)
    assert_response :redirect
    assert { !PostLike.exists?(id: like.id) }
  end

  test '#destroy not authorized' do
    like = post_likes(:one)

    delete post_like_path(like.post)
    assert_response :redirect
    assert { PostLike.exists?(id: like.id) }
    assert { flash[:alert].present? }
  end
end
