# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def show
    @post = Post.find(params[:id])
    @like = current_user ? @post.likes.find_by(creator_id: current_user.id) : false
    @comments = @post.comments.roots
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(permitted_params)

    if @post.save
      redirect_to root_path, notice: I18n.t('posts.create.success')
    else
      render :new, status: :unprocessable_content, alert: I18n.t('posts.create.failure')
    end
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
