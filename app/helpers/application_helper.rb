module ApplicationHelper
  def current_page?(controller)
    "current" if !!controller_path.match(/^#{controller}$/)
  end
end
