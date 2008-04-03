require File.dirname(__FILE__) + '/../test_helper'

class OrderTest < ActiveSupport::TestCase
  # ASSOCIATIONS
  def test_should_belong_to_user
    assert Order.new.respond_to?(:user)
  end

  def test_should_have_many_order_items
    assert Order.new.respond_to?(:order_items)
  end

  # INSTANCE_METHODS
  def test_should_calculate_amount_on_save
    order = orders(:first)
    expected = 0
    order.order_items.each do |order_item|
      expected += order_item.total_cost
    end
    order.save
    assert_equal expected, order.amount
  end

  def test_should_update_with_response
    
  end
end
