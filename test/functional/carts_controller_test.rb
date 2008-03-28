require File.dirname(__FILE__) + '/../test_helper'
require 'carts_controller'

# Re-raise errors caught by the controller.
class CartsController; def rescue_action(e) raise e end; end

class CartsControllerTest < ActionController::TestCase

  def setup
    @controller = CartsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # SHOW
  def test_should_redirect_if_not_logged_in
    get :show
    assert_redirected_to login_path
  end

  def test_should_render_show_template_on_show
    login_as :quentin
    get :show
    assert_template "show"
  end

  def test_should_find_cart_on_show
    login_as :quentin
    get :show
    assert assigns(:cart)
  end

  def test_should_create_cart_if_none_exists
    user = users(:aaron)
    assert user.cart.nil?

    login_as :aaron
    assert_difference 'Cart.count' do 
      get :show
    end
  end

  def test_should_have_heading_on_show_with_cart_count
    login_as :quentin
    get :show
    expected = users(:quentin).cart.cart_items.count
    assert_tag :h1, :content => "Your Cart (#{expected})"
  end

  # ADD
  def test_should_find_product_to_add_to_cart
    login_as :quentin
    post :add, cart_item_params
    assert assigns(:product)
  end

  def test_should_assign_variable_for_cart_item
    login_as :quentin
    post :add, cart_item_params
    assert assigns(:cart_item)
  end

  def test_should_belong_to_a_product_when_added
    login_as :quentin
    post :add, cart_item_params
    assert_not_nil assigns(:cart_item).product
  end

  def test_should_copy_product_price_to_cart_item
    login_as :quentin
    post :add, cart_item_params
    assert_equal assigns(:product).price, assigns(:cart_item).price
  end

  def test_should_create_cart_item
    login_as :quentin
    assert_difference 'CartItem.count' do 
      post :add, cart_item_params
    end
  end

  def test_should_have_flash
    login_as :quentin
    post :add, cart_item_params
    assert !flash.empty?
  end

  def test_should_have_flash_success_if_successful
    login_as :quentin
    post :add, cart_item_params
    assert flash.has_key?(:notice)
  end

  def test_should_have_flash_error_if_fail
    login_as :quentin
    post :add, cart_item_params(:cart_item => { :quantity => nil })
    assert flash.has_key?(:error)
  end

  def test_should_redirect_to_product_page
    login_as :quentin
    post :add, cart_item_params
    assert_redirected_to product_path(assigns(:product))
  end

  # UPDATE  
  def test_should_require_login
    delete :remove
    assert_redirected_to login_path
  end

  # REMOVE
  def test_should_require_login
    delete :remove
    assert_redirected_to login_path
  end

  def test_should_remove_cart_item
    login_as :quentin
    assert_difference 'CartItem.count', -1 do 
      delete :remove, :cart_item => cart_items(:first).id
    end
  end

  def test_should_have_flash
    login_as :quentin
    delete :remove, :cart_item => cart_items(:first).id
    assert flash.has_key?(:notice)
  end

  def test_should_redirect_to_cart_after_remove
    login_as :quentin
    delete :remove, :cart_item => cart_items(:first).id
    assert_redirected_to cart_path
  end

  # CLEAR
  def test_should_require_login
    delete :clear
    assert_redirected_to login_path
  end

  def test_should_remove_cart_items
    login_as :quentin
    post :add, cart_item_params
    # TODO: should probably use the assert_difference stylee here
    assert_not_equal 0, users(:quentin).cart.cart_items.size
    delete :clear
    assert_equal 0, users(:quentin).cart.cart_items.size
  end

  def test_should_have_flash
    login_as :quentin
    delete :clear
    assert !flash.empty?
  end

  def test_should_redirect_to_show_when_cleared
    login_as :quentin
    delete :clear
    assert_redirected_to cart_path
  end

  private
  def cart_item_params(options = { })
    { :product_id => products(:first).id,
      :cart_item => { :quantity => 1 } }.merge(options)
  end

end
