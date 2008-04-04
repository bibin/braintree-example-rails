require File.dirname(__FILE__) + '/../test_helper'
require 'orders_controller'
require 'digest/md5'

# Re-raise errors caught by the controller.
class OrdersController; def rescue_action(e) raise e end; end

class OrdersControllerTest < ActionController::TestCase

  def setup
    @controller = OrdersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # INDEX

  # CREATE
  def test_should_require_login_on_index
    post :create
    assert_redirected_to login_path
  end

  def test_should_require_a_cart_on_create
    login_as :aaron
    post :create
    assert users(:aaron).cart.nil?
    assert_redirected_to products_path
  end

  def test_should_require_an_unempty_cart_on_create
    cart = users(:quentin).cart
    login_as :quentin
    cart.clear
    post :create
    assert_redirected_to products_path
  end

  def test_should_assign_variable_for_order_on_create
    login_as :quentin
    post :create
    assert assigns(:order)
  end

  def test_should_create_order_on_create
    login_as :quentin
    assert_difference 'Order.count' do 
      post :create
    end
  end

  def test_should_redirect_to_checkout_on_successful_create
    login_as :quentin
    post :create
    assert_redirected_to checkout_order_path( assigns(:order) )
  end

  # CHECKOUT
  def test_should_find_an_order_on_checkout
    login_as :quentin
    get :checkout, :id => users(:quentin).orders.first.id
    assert assigns(:order)
  end

  def test_should_require_login_on_checkout
    get :checkout, :id => 5
    assert_redirected_to login_path
  end

  def test_should_assign_variable_for_gateway_request
    login_as :quentin
    get :checkout, :id => users(:quentin).orders.first.id
    assert assigns(:gateway_request)
  end

  def test_should_have_proper_action_on_checkout_form
    login_as :quentin
    get :checkout, :id => users(:quentin).orders.first.id
    assert_tag :tag => "form", :attributes => { :action => BRAINTREE[:transact_api_url] }
  end

  def test_should_have_hidden_braintree_hash_amounts_on_checkout_form
    login_as :quentin
    get :checkout, :id => users(:quentin).orders.first.id
    assert_tag :tag => "div", :children => { :count => 7, :only => { :tag => "input" } }
  end
  

  # GATEWAY_RESPONSE
  def test_should_assign_variable_for_order
    # FIXME: I need params on theses here.
    login_as :quentin
    get :gateway_response, :id => users(:quentin).orders.first.id
    assert assigns(:order)
  end

  def test_should_assign_variable_for_response
    login_as :quentin
    get :gateway_response, :id => users(:quentin).orders.first.id
    assert assigns(:response)
  end

  def test_should_update_order_with_response
    
  end
  
  # STATUS
  
end
