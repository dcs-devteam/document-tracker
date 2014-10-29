module Admin::OfficesHelper
  def admin_button_class(office)
    "red" if office.admin?
  end
end
