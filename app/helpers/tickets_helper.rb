module TicketsHelper
  
  TICKET_STATUSES = {
    "Open"        => "OP",
    "In Progress" => "IP",
    "Waiting For" => "WF",
    "Aborted"     => "AB",
    "Closed"      => "CL"
  }
  
  TICKET_PRIORITIES = {
    "Low"    => 'low',
    "Normal" => 'normal',
    "High"   => 'high',
    "ASAP"   => 'asap'
}
  
  def check_ticket_status(status)
    if status == 'CL'
      content_tag(:span, "closed", :class => 'ui small horizontal label')
    elsif status == 'IP'
      content_tag(:span, "in progress", :class => 'ui small horizontal label')
    elsif status == 'WF'
      content_tag(:span, "waiting for", :class => 'ui small horizontal label')
    elsif status == 'AB'
      content_tag(:span, "aborted", :class => 'ui small horizontal label')
    elsif status == 'OP'
      content_tag(:span, "open", :class => 'ui small horizontal label')
    end
  end
  
  def check_ticket_priority_label(priority)
    if priority == 'low'
      content_tag(:span, "low", :class => 'ui small horizontal label')
    elsif priority == 'normal'
      content_tag(:span, "normal", :class => 'ui yellow small horizontal label')
    elsif priority == 'high'
      content_tag(:span, "high", :class => 'ui orange small horizontal label')
    elsif priority == 'asap'
      content_tag(:span, "asap", :class => 'ui red small horizontal label')
    end
  end
  
  def check_ticket_priority(priority)
    if priority == 'asap'
      content_tag(:span, "asap", :class => 'ui red empty circular label')
    elsif priority == 'high'
      content_tag(:span, "", :class => 'ui orange empty circular label')
    elsif priority == 'normal'
      content_tag(:span, "", :class => 'ui yellow empty circular label')
    elsif priority == 'low'
      content_tag(:span, "", :class => 'ui empty circular label')
    end
  end
  
  def options_for_status
    TICKET_STATUSES
  end
  
  def options_for_priority
    TICKET_PRIORITIES
  end
  

  
  
  
end
