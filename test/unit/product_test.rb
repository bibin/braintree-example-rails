require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < ActiveSupport::TestCase
  # ASSOCIATIONS
  def test_should_have_many_cart_items
    assert Product.new.respond_to?(:cart_items)
  end

  def test_should_have_many_order_items
    assert Product.new.respond_to?(:order_items)
  end

  # VALIDATIONS
  def test_should_require_title
    product = new_product(:name => nil)
    assert !product.save
  end

  def test_should_require_description
    product = new_product(:description => nil)
    assert !product.save
  end

  def test_should_name_of_proper_length
    # TODO: write helper method for creating long strin
  end

  def test_should_require_numericality_of_price
    product = new_product(:price => "not a number")
    assert !product.save
  end

  # PERMALINK_FU
  def test_should_have_permalink_field
    assert_not_nil Product.permalink_field
  end

  def test_should_have_id_and_permalink_in_to_param
    product = new_product(:name => "huzzah!")
    expected = "#{product.id}-#{product.permalink}"
    assert_equal expected, product.to_param
  end

  # FILTERED_COLUMN
  def test_should_have_filtered_column
    filtered = [:description]
    assert_equal filtered, Product.new.filtered_attributes
  end

  def test_should_filter_description_field
    product = new_product
    assert_nil product.description_html
    product.save
    assert_not_nil product.description_html
  end

  # TEST HELPERS
  def test_should_save_new_product
    product = new_product
    assert product.save
  end

  private
  def new_product(options = { })
    Product.new({:name => "Willy's Widgets",
                 :description => "These fabulous widgets are wet, wild, and Willy's!",
                 :price => 10.99,
                 :filter => "textile_filter" }.merge(options))
  end
end
