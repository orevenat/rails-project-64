# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test '#new' do
    @user = users(:one)
    sign_in @user

    get new_category_path
    assert_response :success
  end

  test '#new not authorized' do
    get new_category_path
    assert_response :redirect
  end

  test '#create' do
    @user = users(:one)
    sign_in @user

    attrs = {
      name: Faker::Book.title
    }

    post categories_path, params: { category: attrs }
    assert_response :redirect
    assert { Category.exists?(name: attrs[:name]) }
  end

  test '#create not authorized' do
    attrs = {
      name: Faker::Book.title
    }

    post categories_path, params: { category: attrs }
    assert_response :redirect
    assert { !Category.exists?(name: attrs[:name]) }
    assert { flash[:alert].present? }
  end
end
