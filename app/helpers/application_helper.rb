# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def options_for_filters
    [["Textile", "textile_filter"],["Markdown", "markdown_filter"], ["SmartyPants", "smartypants_filter"]]
  end

  def options_for_cart_item_quantity
    %w( 1 2 3 4 5 6 7 8 9 10)
  end

  def cart_item_count
    unless current_user.cart.nil?
      current_user.cart.cart_items.count
    else
      0
    end
  end

  def flash_div *keys
    divs = keys.select { |k| flash[k] }.collect do |k|
      content_tag :div, flash[k], :class => "flash #{k}" 
    end
    divs.join
  end

end
