require File.dirname(__FILE__) + '/../test_helper'

class CartItemTest < ActiveSupport::TestCase
  # ASSOCIATIONS
  def test_should_belong_to_cart
    assert CartItem.new.respond_to?(:cart)
  end

  def test_should_belong_to_product
    assert CartItem.new.respond_to?(:product)
  end
  
  # VALIDATIONS
  def test_should_require_a_numeric_quantity
    cart_item = new_cart_item(:quantity => nil)
    assert !cart_item.valid?
  end

  def test_should_require_a_numeric_product_id
    cart_item = new_cart_item(:product_id => nil)
    assert !cart_item.valid?
  end

  def test_should_require_a_numerica_cart_id
    cart_item = new_cart_item(:cart_id => nil)
    assert !cart_item.valid?
  end

  # INSTANCE_METHODS
  def test_should_calculate_total_cost
    quantity, price = 10, 10.00
    expected = quantity * price
    cart_item = new_cart_item(:quantity => quantity, :price => price)
    assert_equal expected, cart_item.total_cost
  end

  private
  def new_cart_item(options = { })
    CartItem.new(
                 { :product_id => products(:first).id,
                   :cart_id    => carts(:first).id,
                   :quantity   => 1,
                   :price      => products(:first).price}.merge(options)
                 )
  end
end