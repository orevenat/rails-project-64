class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, alert: "Please sign in." }
        format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
      end
    end
  end
end
