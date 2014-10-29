class Admin::OfficesController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_admin_access

  def index
    @offices = Office.all
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
    Office.destroy params[:id]
    redirect_to admin_offices_path
  end

  def toggle_admin_privilege
    office = Office.find params[:id]
    office.toggle_admin!
    redirect_to admin_offices_path
  end

  private

    def office_params
      params.require(:office).permit :name, :email
    end
end
