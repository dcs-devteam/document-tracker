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
end
