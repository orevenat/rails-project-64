class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = post.comments.build(creator: current_user, **permitted_params)

    if @comment.save
      redirect_to @post, notice: t(".published")
    else
      flash[:alert] = @comment.errors.full_messages.join(', ')
      redirect_to @post
    end
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end

  def permitted_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
