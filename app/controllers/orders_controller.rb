require 'digest/md5'
class OrdersController < ApplicationController
  include Braintree::Helpers
  
  before_filter :login_required

  def index
  end

  def show
  end

  # This method takes a +Cart+ and makes it into an +Order+ along with
  # each +CartItem+.  After that, it redirects the user to the
  # <tt>checkout</tt> action, where the credit card information is 
  # collected to post to the Braintree Gateway.
  def create
    @cart = current_user.cart    
    unless current_user.cart.nil? || @cart.empty?
      @order = @cart.create_order
      redirect_to checkout_order_path(@order)
    else
      flash[:notice] = "There is nothing in your cart."
      redirect_to products_path
    end
  end

  # Prepares a hash to be used for the Transparent Redirect
  # authentication method.  User has 15 minutes from the time
  # this hash is generated to submit the form.
  def checkout
    @order = Order.find params[:id]
    prepare_hash_variables
    create_hash_from_variables
  end

  def gateway_response
    @order = Order.find params[:id]
    @response = GatewayResponse.new(params)
    if @response.is_successful?
      flash[:notice] = @response.message_for_success
      redirect_to order_path(@order)
    else
      flash[:notice] = @response.message_for_failure
      redirect_to checkout_order_path(@order)
    end
  end

  def status
    @order = Order.find params[:id]
  end

  private
  def prepare_hash_variables
    @time = formatted_utc_time
  end

  def create_hash_from_variables
    @tr_hash = hash_value(@order.id, @order.amount, @time, BRAINTREE[:key])
  end
end
