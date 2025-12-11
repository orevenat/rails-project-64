class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = post.likes.build(user: current_user)

    if @like.save
      redirect_to @post, notice: t(".liked")
    else
      redirect_to @post, alert: t(".unliked")
    end
  end

  def destroy
    @like = post.likes.find_by(user: current_user, id: params[:id])
    redirect_to post, alert: t(".like_not_found") unless @like

    if @like.destroy
      redirect_to @post, notice: t(".like_removed")  
    else
      errors = @like.errors.full_messages.join(', ')
      redirect_to @post, alert: t(".like_remoing_errors", errors)
    end
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end
end
