class Office::DocumentsController < DocumentsController
  def index
    @documents = current_office.routed_documents.alive
  end
end
