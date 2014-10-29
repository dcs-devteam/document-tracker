class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_role, :current_role_code

  protected

    def current_role
      session[:role] || "office"
    end

    def current_role_code
      return 1 if current_role == "admin"
      return 0
    end

    def fake_flash(key, value = nil)
      if value
        Rails.cache.write key, value
      else
        object = Rails.cache.read key
        Rails.cache.delete key
        object
      end
    end
end
