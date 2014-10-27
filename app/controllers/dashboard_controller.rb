class DashboardController < ApplicationController
  before_filter :authenticate_office!

  def index
  end

  def switch
    if params[:role] == "office"
      session[:role] = "office"
    elsif params[:role] == "admin" and current_office.admin?
      session[:role] = "admin"
    end
    redirect_to dashboard_path, notice: "Switched to #{session[:role]} account."
  end
end
