class AjaxController < ApplicationController
  def seen_notifications
    Notification.find(params[:notifications].split(",")).map { |n| n.seen! }
    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

  def poll_notifications
    notifications = current_office.notifications.where(role: role_code, seen: false).where "id > ?", params[:offset]
    respond_to do |format|
      format.json { render json: notifications }
    end
  end

  def more_notifications
    last_date = Date.parse params[:last_date]
    notifications = []
    current_office.notifications.where(role: role_code).where("DATE(created_at) < DATE(:date)", { date: last_date }).order("-id").group("DATE(created_at), id").limit(1).map(&:created_at).each do |range|
      notifications += current_office.notifications.where(role: role_code).where("DATE(created_at) = DATE(:date)", { date: range }).order "-id"
    end
    if notifications.any?
      response = { notifications: notifications.map(&:to_json), date: notifications.first.created_at.strftime("%B %e, %Y") }
    else
      response = { empty: true }
    end
    respond_to do |format|
      format.json { render json: response }
    end
  end

  private

    def role_code
      current_role_code < 2 ? [0, 1] : 2
    end
end
