module ApplicationHelper
  def current_page?(controller)
    !!controller_path.match(/^#{controller}$/)
  end
end
