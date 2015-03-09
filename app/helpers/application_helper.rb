module ApplicationHelper
  
  def nav_link(text, path)
    options = current_page?(path) ? "active" : ""
    content_tag(:a, :class => options) do
      link_to text, path
    end
  end
  
  # Returns the full title on a per-page basis.       # Documentation comment
  def full_title(page_title = '')                     # Method def, optional arg
    base_title = ":ticketBox"  # Variable assignment
    if page_title.empty?                              # Boolean test
      base_title                                      # Implicit return
    else
      "#{page_title} | #{base_title}"                 # String interpolation
    end
  end
  
end
