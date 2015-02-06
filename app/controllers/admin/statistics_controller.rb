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

    accumulation_start = OfficeMeta.where(key: 'reset-date').first
    if accumulation_start
        start_date = Date.parse accumulation_start.value
    else
        start_date = Document.first.created_at.beginning_of_day
    end
    @accumulated_own_pending = Document.alive.where("status = 1 AND created_at > :date", { date: start_date }).count
    @accumulated_own_completed = Document.alive.where("status = 2 AND created_at > :date", { date: start_date }).count
    @accumulated_own_rejected = Document.alive.where("status = 3 AND created_at > :date", { date: start_date }).count
    @accumulated_routed_incoming = DocumentRoute.where("status = 0 AND created_at > :date", { date: start_date }).count
    @accumulated_routed_pending = DocumentRoute.where("status = 1 AND created_at > :date", { date: start_date }).count
    @accumulated_routed_released = DocumentRoute.where("status = 2 AND created_at > :date", { date: start_date }).count
    @accumulated_routed_completed = DocumentRoute.where("status = 4 AND created_at > :date", { date: start_date }).count
    @accumulated_routed_rejected = DocumentRoute.where("status = 3 AND created_at > :date", { date: start_date }).count
  end
end
