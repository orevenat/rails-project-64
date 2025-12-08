class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = post.likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_to @post, notice: "Пост понравился" }
        format.json { render json: { likes_count: @post.likes.count }, status: :created }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: "Не удалось поставить лайк" }
        format.json { render json: @like.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @like = post.likes.find_by(user: current_user, id: params[:id])
    redirect_to post, alert: "Лайк не найден" unless @like

    if @like.destroy
      respond_to do |format|
        format.html { redirect_to @post, notice: "Лайк удален" }
        format.json { render json: { likes_count: @post.likes.count } }
        format.turbo_stream
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
