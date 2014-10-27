class PagesController < ApplicationController
  def home
    if office_signed_in?
      session[:role] = "office"
      return redirect_to dashboard_path
    end
    render "devise/sessions/new"
  end
end
