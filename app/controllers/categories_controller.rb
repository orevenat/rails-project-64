# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.build(permitted_params)

    if @category.save
      redirect_to root_path, notice: I18n.t('.success')
    else
      render :new, status: :unprocessable_content, alert: I18n.t('.failure')
    end
  end

  private

  def permitted_params
    params.expect(category: %i[name])
  end
end
