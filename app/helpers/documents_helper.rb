module DocumentsHelper
  def document_types_options
    DocumentType.usable_by(current_office).map { |t| [t.name, t.id] }
  end

  def office_staffs_options
    current_office.office_staffs.order("name").map { |s| [s.name, s.name] }
  end

  def route_status_indicator(status)
    return "blue" if status == "completed"
    return "green" if ["received", "released"].include? status
    return "red" if status == "rejected"
  end

  def current_documents_path(options = {})
    options.delete(:filter) if params[:filter] == options[:filter]
    return office_documents_path(options) if controller_path == "office/documents"
    return documents_path(options) if current_role == "office"
    return admin_documents_path(options) if current_role == "admin"
  end

  def current_document_path(document)
    return office_document_path(document) if controller_path == "office/documents"
    return document_path(document) if current_role == "office"
    return admin_document_path(document) if current_role == "admin"
  end

  def current_filter?(filter)
    params[:filter] == filter
  end

  def page_title
    return "Your Documents" if controller_path == "documents"
    return "Routed Documents" if controller_path == "office/documents"
    return "All Documents" if controller_path == "admin/documents"
  end
end
