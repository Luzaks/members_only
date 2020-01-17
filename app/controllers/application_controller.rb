class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def sign_in(user)
      remember_token = User.new_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.digest(remember_token))
      self.current_user = user
    end
end
