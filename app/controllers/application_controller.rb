class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private
    def redirect_logged_in_user
      if logged_in?
        redirect_to root_url
      end
    end

  def require_login
    unless logged_in?
      respond_to do |format|
        format.html { redirect_to login_url }
        format.json { render json: { nope: true }, status: :unauthorized }
      end
    end
  end
end
