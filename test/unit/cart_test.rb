require File.dirname(__FILE__) + '/../test_helper'

class CartTest < ActiveSupport::TestCase
  # ASSOCIATIONS
  def test_should_belong_to_user
    assert Cart.new.respond_to?(:user)
  end

  def test_should_have_many_cart_items
    assert Cart.new.respond_to?(:cart_items)
  end

  # INSTANCE_METHODS
  def test_should_calculate_at_total_cost
    # FIXME: this is a bad test with hardcoded values
    cart = carts(:first)
    assert_equal 1.5, cart.total_cost
    # FIXME: just realized that price from product is in controller
    cart.cart_items.create(:product_id => products(:first).id, :quantity => 10, :price => 10.00 )
    assert_equal 101.5, cart.total_cost
  end
end
