module DocumentsHelper
  def document_types_options
    DocumentType.usable_by(current_office).map { |t| [t.name, t.id] }
  end

  def office_staffs_options
    current_office.office_staffs.map { |s| [s.name, s.name] }
  end

  def route_status_indicator(status)
    return "blue" if status == "completed"
    return "green" if ["received", "released"].include? status
    return "red" if status == "rejected"
  end

  def current_documents_path(options)
    options.delete(:filter) if params[:filter] == options[:filter]
    return documents_path(options) if current_role == "office"
    return admin_documents_path(options) if current_role == "admin"
  end

  def current_filter?(filter)
    "highlighted" if params[:filter] == filter
  end
end
