module ApplicationHelper
  def current_page?(controller)
    !!controller_name.match(/#{controller}$/)
  end
end
