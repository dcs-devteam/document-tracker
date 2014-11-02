class DocumentsController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_office_access
  before_filter :require_manage_privileges, only: [:update, :destroy]

  helper_method :has_manage_privileges?

  def index
    @documents = Document.by(current_office).alive.order("-id")
    @document = fake_flash(:document_create) || Document.new
    @flash_document = fake_flash :document_update
  end

  def show
    @document = Document.find params[:id]
    @flash_document = fake_flash :document_update
    if @document.onhold?
      first_route = @document.document_type.offices.first
      @route = DocumentRoute.new document_id: @document.id, office_id: first_route.id
    else
      @routes = @document.document_routes.order("id")
    end
    @offices = Office.alive
  end

  def create
    document = Document.new document_params
    document.office_id = current_office.id
    if document.save
      return redirect_to document_path(document), notice: "Document successfully created."
    end
    fake_flash :document_create, document
    redirect_to documents_path
  end

  def update
    document = Document.find params[:id]
    if document.update document_params
      return redirect_to :back, notice: "Document successfully updated."
    end
    fake_flash :document_update, document
    redirect_to :back
  end

  def destroy
    document = Document.find params[:id]
    document.update! erased: true
    redirect_to documents_path, notice: "Document successfully deleted."
  end

  private

    def document_params
      params.require(:document).permit :name, :document_type_id, :owner
    end

    def has_manage_privileges?(document)
      document.office == current_office
    end

    def require_manage_privileges
      document = Document.find params[:id]
      unless has_manage_privileges? document
        return redirect_to :back, "You need to have manage privileges for the document to do that action."
      end
    end
end
