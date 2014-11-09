class DashboardController < ApplicationController
  before_filter :authenticate_office!

  def index
    @notifications = []
    current_office.notifications.where(role: role_code).order("-id").group("DATE(created_at), id").limit(3).map(&:created_at).each do |range|
      @notifications += current_office.notifications.where(role: role_code).where("DATE(created_at) = DATE(:date)", { date: range }).order("-id")
    end
    @notifications.uniq!
  end

  def switch
    if params[:role] == "office"
      session[:role] = "office"
    elsif params[:role] == "admin" and current_office.admin?
      session[:role] = "admin"
    end
    redirect_to dashboard_path, notice: "Switched to #{session[:role]} account."
  end

  private

    def role_code
      current_role_code < 2 ? [0, 1] : 2
    end
end
