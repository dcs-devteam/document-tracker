class Admin::DocumentsController < DocumentsController
  skip_before_filter :require_office_access
  before_filter :require_admin_access

  def index
    case params[:filter]
    when "being_processed"
      @documents = Document.pending.alive.order("-id")
    when "completed"
      @documents = Document.approved.alive.order("-id")
    when "rejected"
      @documents = Document.rejected.alive.order("-id")
    else
      @documents = Document.where.not(status: 0).alive.order("-id")
    end
  end
end
