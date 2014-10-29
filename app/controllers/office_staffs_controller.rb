class OfficeStaffsController < ApplicationController
  before_filter :authenticate_office!

  def index
    @office_staffs = current_office.office_staffs
    @office_staff = fake_flash(:office_staff_create) || OfficeStaff.new
    @flash_office_staff = fake_flash :office_staff_update
  end

  def create
    office_staff = OfficeStaff.new office_staff_params
    office_staff.office_id = current_office.id
    if office_staff.save
      return redirect_to office_staffs_path, notice: "Office staff successfully created."
    end
    fake_flash :office_staff_create, office_staff
    redirect_to office_staffs_path
  end

  def update
    office_staff = OfficeStaff.find params[:id]
    if office_staff.update office_staff_params
      return redirect_to office_staffs_path, notice: "Office staff successfully updated."
    end
    fake_flash :office_staff_update, office_staff
    redirect_to office_staffs_path
  end

  def destroy
    office_staff = OfficeStaff.find params[:id]
    office_staff.update! active: false
    redirect_to office_staffs_path, notice: "Office staff successfully deleted."
  end

  private

    def office_staff_params
      params.require(:office_staff).permit(:name)
    end
end
