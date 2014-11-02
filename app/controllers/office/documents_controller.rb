class Office::DocumentsController < DocumentsController
  def index
    @documents = current_office.routed_documents.alive.order("-documents.id")
  end
end
