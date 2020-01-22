class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def sign_in(user)
    session[:user_id] = user.id
    remember_token = User.new_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticate(cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  def sign_out
    @current_user = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
  end
end
