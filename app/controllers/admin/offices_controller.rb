class Admin::OfficesController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_admin_access

  def index
    @offices = Office.alive.order("id")
    @office = Office.new
    @flash_office = fake_flash(:office_update)
  end

  def update
    office = Office.find params[:id]
    if office.update office_params
      return redirect_to admin_offices_path, notice: "Office account successfully updated."
    end
    fake_flash :office_update, office
    redirect_to admin_offices_path
  end

  def destroy
    office = Office.find params[:id]
    if current_office == office
      return redirect_to admin_offices_path, alert: "Only other admin accounts can delete your account."
    end
    office.update! erased: true
    redirect_to admin_offices_path, notice: "Office account successfully deleted."
  end

  def toggle_admin_privilege
    office = Office.find params[:id]
    if current_office == office
      return redirect_to admin_offices_path, alert: "Only other admin accounts can grant/revoke your admin privileges."
    end
    office.toggle_admin!
    Notification.toggle_admin office
    redirect_to admin_offices_path
  end

  private

    def office_params
      params.require(:office).permit :name, :email
    end
end
