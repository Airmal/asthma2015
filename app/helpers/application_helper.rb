module ApplicationHelper
  def get_page_id ctrl, action
    [Settings.app_page_perfix, Digest::MD5.hexdigest("#{ctrl}-#{action}")[0..7]].join('-')
  end

  def link_to_unless_with_block condition, uri, options, &block
   link_to_unless condition, capture(&block), uri, options
  end 
end
