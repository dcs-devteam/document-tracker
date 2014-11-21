class Admin::StatisticsController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_admin_access

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @offices = Office.alive
    @total_pending = Document.alive.where("status = 1 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @total_completed = Document.alive.where("status = 2 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @total_rejected = Document.alive.where("status = 3 AND DATE(created_at) = DATE(:date)", { date: @date }).count
  end
end
