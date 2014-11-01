module ApplicationHelper
  def current_page_class(controller)
    "current" if !!controller_path.match(/^#{controller}$/)
  end
end
