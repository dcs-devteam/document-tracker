class Office::DocumentsController < DocumentsController
  def index
    case params[:filter]
    when "incoming"
      @documents = current_office.document_routes.incoming.order("-id")
    when "received"
      @documents = current_office.document_routes.received.order("-id")
    when "released"
      @documents = current_office.document_routes.released.order("-id")
    when "completed"
      @documents = current_office.document_routes.completed.order("-id")
    when "rejected"
      @documents = current_office.document_routes.rejected.order("-id")
    else
      @documents = current_office.document_routes.order("-id")
    end
    @documents = @documents.map(&:document).uniq.select { |document| !document.erased }
  end
end
