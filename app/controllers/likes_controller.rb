class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = post.likes.build(creator: current_user)


    if @like.save
      redirect_to @post, notice: "Пост понравился"
    else
      redirect_to @post, alert: "Не удалось поставить лайк"
    end
  end

  def destroy
    @like = post.likes.find_by(creator: current_user, id: params[:id])
    redirect_to post, alert: "Лайк не найден" unless @like

    if @like.destroy
      respond_to do |format|
        format.html { redirect_to @post, notice: "Лайк удален" }
        format.json { render json: { likes_count: @post.likes.count } }
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: "Не удалось удалить лайк" }
        format.json { render json: @like.errors, status: :unprocessable_content }
      end
    end
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end
end
