module ApplicationHelper
  def auth_token
    html = "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">"
    html.html_safe
  end

  def submit(value)
    html = "<input type=\"submit\" value=\"#{value}\">"
    html.html_safe
  end
end
