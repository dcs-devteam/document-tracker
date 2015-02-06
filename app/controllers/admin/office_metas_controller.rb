class Admin::OfficeMetasController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_admin_access

  def create_or_update
    office_meta = OfficeMeta.where(key: params[:key]).first
    unless office_meta
      office_meta = OfficeMeta.create key: params[:key]
    end
    office_meta.update! value: Time.now.to_s
    redirect_to :back, notice: "Operation successful."
  end
end
