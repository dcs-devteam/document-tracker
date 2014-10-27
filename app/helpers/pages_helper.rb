module PagesHelper
  def resource_name
    :office
  end

  def resource
    @resource ||= Office.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:office]
  end
end
