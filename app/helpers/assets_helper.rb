module AssetsHelper
  
  WARE_CLASSES = {
    'Hardware'  => 'hardware',
    'Software'  => 'software',
    'Other'     => 'other'
  }
  
  def options_for_ware
    WARE_CLASSES
  end
  
  def status_tag(boolean, options={})
    options[:true_text]  ||= ''
    options[:false_text] ||= ''
    
    if boolean
      content_tag(:span, options[:true_text], :class => 'status true')
    else
      content_tag(:span, options[:false_text], :class => 'status false')
    end
  end
  
end
