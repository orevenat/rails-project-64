# frozen_string_literal: true

class PostsController < ApplicationController
  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(permitted_params)

    if @post.save
      redirect_to root_path, notice: I18n.t('posts.create.success')
    else
      render :new, status: :unprocessable_entity, alert: I18n.t('posts.create.failure')
    end
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
