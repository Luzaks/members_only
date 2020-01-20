class ApplicationController < ActionController::Base
   include SessionsHelper
    protect_from_forgery with: :exception

    def forgett(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forgett(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    
end
