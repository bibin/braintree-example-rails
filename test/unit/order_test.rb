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
  def test_should_calculate_at_total_cost
    # FIXME: this is a bad test with hardcoded values
#    order = orders(:first)
#    assert_equal 1.5, order.total_cost
    # FIXME: just realized that price from product is in controller, should pass product & order to make order item
#    order.order_items.create(:product_id => products(:first).id, :quantity => 10, :price => 10.00 )
#    assert_equal 101.5, order.total_cost
  end
end
