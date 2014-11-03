class DocumentRoutesController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_office_access

  def create
    route = DocumentRoute.create document_route_params
    route.document.pending!
    redirect_to document_path(route.document), notice: "Document forwarded to <strong>#{route.office.name}</strong>."
  end

  def receive
    ActiveRecord::Base.transaction do
      document_route = DocumentRoute.find params[:id]
      document_route.receive!
      return redirect_to office_document_path(document_route.document), notice: "You received <strong>#{document_route.document.name}</strong>."
    end
    redirect_to :back
  end

  def release
    ActiveRecord::Base.transaction do
      current_route = DocumentRoute.find params[:id]
      next_route = DocumentRoute.create document_route_params
      current_route.release! next_route
      return redirect_to office_document_path(current_route.document), notice: "You forwarded <strong>#{current_route.document.name}</strong> to <strong>#{next_route.office.name}</strong>."
    end
    redirect_to :back
  end

  def reject
    ActiveRecord::Base.transaction do
      document_route = DocumentRoute.find params[:id]
      document_route.reject!
      return redirect_to office_document_path(document_route.document), notice: "You rejected <strong>#{document_route.document.name}</strong>."
    end
    redirect_to :back
  end

  def complete
    ActiveRecord::Base.transaction do
      document_route = DocumentRoute.find params[:id]
      document_route.complete!
      return redirect_to office_document_path(document_route.document), notice: "You completed processing <strong>#{document_route.document.name}</strong>."
    end
    redirect_to :back
  end

  private

    def document_route_params
      params.require(:document_route).permit :document_id, :office_id
    end
end
