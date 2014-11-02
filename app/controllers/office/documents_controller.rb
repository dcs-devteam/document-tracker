class Office::DocumentsController < DocumentsController
  def index
    case params[:filter]
    when "incoming"
      @documents = current_office.document_routes.incoming
    when "received"
      @documents = current_office.document_routes.received
    when "released"
      @documents = current_office.document_routes.released
    when "completed"
      @documents = current_office.document_routes.completed
    when "rejected"
      @documents = current_office.document_routes.rejected
    else
      @documents = current_office.document_routes
    end
    @documents = @documents.map(&:document).uniq.select { |document| !document.erased }
  end
end
