require File.dirname(__FILE__) + '/../test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # ASSOCIATIONS
  def test_should_belong_to_order
    assert OrderItem.new.respond_to?(:order)
  end

  def test_should_belong_to_product
    assert OrderItem.new.respond_to?(:product)
  end
  
  # VALIDATIONS
  def test_should_require_a_numeric_quantity
    order_item = new_order_item(:quantity => nil)
    assert !order_item.valid?
  end

  def test_should_require_a_numeric_product_id
    order_item = new_order_item(:product_id => nil)
    assert !order_item.valid?
  end

  # INSTANCE_METHODS
  def test_should_calculate_total_cost
    quantity, price = 10, 10.00
    expected = quantity * price
    order_item = new_order_item(:quantity => quantity, :price => price)
    assert_equal expected, order_item.total_cost
  end

  private
  def new_order_item(options = { })
    OrderItem.new(
                 { :product_id => products(:first).id,
                   :order_id    => orders(:first).id,
                   :quantity   => 1,
                   :price      => products(:first).price}.merge(options)
                 )
  end
end
