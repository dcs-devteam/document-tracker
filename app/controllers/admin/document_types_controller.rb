class Admin::DocumentTypesController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_admin_access

  def index
    @document_types = DocumentType.alive
    @document_type = fake_flash(:document_type_create) || DocumentType.new
    @offices = Office.alive.map { |o| [o.name, o.id] }
    @flash_document_type = fake_flash :document_type_update
  end

  def show
    @document_type = DocumentType.find params[:id]
    @offices = Office.alive.map { |o| [o.name, o.id] }
  end

  def create
    document_type = DocumentType.create document_type_params
    if document_type.valid?
      return redirect_to admin_document_types_path, notice: "Document type successfully created."
    end
    fake_flash :document_type_create, document_type
    redirect_to admin_document_types_path
  end

  def update
    document_type = DocumentType.find params[:id]
    if document_type.update document_type_params
      return redirect_to admin_document_types_path, notice: "Document type successfully updated."
    end
    fake_flash :document_type_update, document_type
    redirect_to admin_document_types_path
  end

  def destroy
    document_type = DocumentType.find params[:id]
    document_type.update! erased: true
    redirect_to admin_document_types_path, notice: "Document type successfully deleted."
  end

  private

    def document_type_params
      params.require(:document_type).permit :name, :route
    end
end
