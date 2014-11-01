module DocumentTypesHelper
  def document_type_plural_path
    current_role == "office" ? document_types_path : admin_document_types_path
  end

  def document_type_singular_path(document_type)
    current_role == "office" ? document_type_path(document_type) : admin_document_type_path(document_type)
  end

  def has_manage_privileges?(document_type)
    current_role == "admin" and document_type.owner.nil? or document_type.owned_by? current_office
  end
end
