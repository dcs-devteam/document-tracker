class Admin::StatisticsController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_admin_access

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @offices = Office.alive.order("id")
    @own_total_pending = Document.alive.where("status = 1 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @own_total_completed = Document.alive.where("status = 2 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @own_total_rejected = Document.alive.where("status = 3 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @routed_total_incoming = DocumentRoute.where("status = 0 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @routed_total_pending = DocumentRoute.where("status = 1 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @routed_total_released = DocumentRoute.where("status = 2 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @routed_total_completed = DocumentRoute.where("status = 4 AND DATE(created_at) = DATE(:date)", { date: @date }).count
    @routed_total_rejected = DocumentRoute.where("status = 3 AND DATE(created_at) = DATE(:date)", { date: @date }).count
  end
end
