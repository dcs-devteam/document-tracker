module DocumentsHelper
  def document_types_options
    DocumentType.usable_by(current_office).map { |t| [t.name, t.id] }
  end

  def office_staffs_options
    current_office.office_staffs.map { |s| [s.name, s.name] }
  end
end
