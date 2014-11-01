class DocumentTypesController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_office_access
  before_filter :has_manage_privileges?, only: [:update, :destroy]

  def index
    @document_types = DocumentType.defaults.alive + DocumentType.by(current_office).alive
    @document_type = fake_flash(:document_type_create) || DocumentType.new
    @flash_document_type = fake_flash :document_type_update
  end

  def show
    @document_type = DocumentType.find params[:id]
  end

  def create
    document_type = DocumentType.new document_type_params
    document_type.owner_id = current_office.id
    if document_type.save
      return redirect_to redirect_path, notice: "Document type successfully created."
    end
    fake_flash :document_type_create, document_type
    redirect_to redirect_path
  end

  def update
    document_type = DocumentType.find params[:id]
    if document_type.update document_type_params
      return redirect_to redirect_path, notice: "Document type successfully updated."
    end
    fake_flash :document_type_update, document_type
    redirect_to redirect_path
  end

  def destroy
    document_type = DocumentType.find params[:id]
    document_type.update! erased: true
    redirect_to redirect_path, notice: "Document type successfully deleted."
  end

  protected

    def document_type_params
      params.require(:document_type).permit :name, :route
    end

    def redirect_path
      document_types_path
    end

    def has_manage_privileges?
      document_type = DocumentType.find params[:id]
      if !document_type.owned_by?(current_office) and !(current_role == "admin" and document_type.owner.nil?)
        redirect_to redirect_path, alert: "You need to have manage privileges for the document type to do that action."
      end
    end
end
