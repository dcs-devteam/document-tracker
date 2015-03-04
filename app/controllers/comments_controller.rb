class CommentsController < ApplicationController
  before_filter :authenticate_office!
  before_filter :require_access_privileges
  before_filter :require_manage_privileges, only: [:destroy]

  helper_method :has_manage_privileges?

  def create
    comment = Comment.new comment_params
    comment.office_id = current_office.id
    if comment.save
      return redirect_to :back, notice: "Comment successfully posted."
    end
    fake_flash :comment_create, comment
    redirect_to :back
  end

  def destroy
    comment = Comment.find params[:id]
    comment.update! erased: true
    redirect_to :back, notice: "Comment successfully deleted."
  end

  private

    def comment_params
      params.require(:comment).permit :body, :document_id, :user_role
    end

    def has_manage_privileges?(comment)
      comment.office == current_office
    end

    def require_manage_privileges
      comment = Comment.find params[:id]
      unless has_manage_privileges? comment
        redirect_to :back, alert: "You need to have manage privileges for the comment to do that action."
      end
    end

    def require_access_privileges
      if Document.exists? params[:id]
        document = Document.find params[:id]
        unless has_access_to? document
          redirect_to dashboard_path, alert: "You need to have access privileges for the document to do that action."
        end
      else
        redirect_to dashboard_path, alert: "The requested document does not exist."
      end
    end
end
