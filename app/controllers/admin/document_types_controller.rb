class Admin::DocumentTypesController < DocumentTypesController
  skip_before_filter :require_office_access
  before_filter :require_admin_access

  def index
    @document_types = DocumentType.defaults.alive
    @document_type = fake_flash(:document_type_create) || DocumentType.new
    @flash_document_type = fake_flash :document_type_update
  end

  def create
    document_type = DocumentType.create document_type_params
    if document_type.valid?
      return redirect_to redirect_path, notice: "Document type successfully created."
    end
    fake_flash :document_type_create, document_type
    redirect_to redirect_path
  end

  protected

    def redirect_path
      admin_document_types_path
    end
end
