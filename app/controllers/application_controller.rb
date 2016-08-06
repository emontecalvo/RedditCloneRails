class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def require_login
    unless current_user
      flash[:errors] ||= []
      flash[:errors] << "You must log in to continue"
      redirect_to new_session_url
    end
  end
end
