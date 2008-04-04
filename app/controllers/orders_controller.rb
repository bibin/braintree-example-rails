require 'digest/md5'
class OrdersController < ApplicationController
  
  before_filter :login_required

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find params[:id]
  end

  # This method takes a +Cart+ and makes it into an +Order+ along with
  # each +CartItem+.  After that, it redirects the user to the
  # <tt>checkout</tt> action, where the credit card information is 
  # collected to post to the Braintree Gateway.
  def create
    @cart = current_user.cart    
    unless current_user.cart.nil? || @cart.empty?
      @order = @cart.create_order
      @order.user = current_user
      @order.save
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
    @gateway_request = Braintree::GatewayRequest.new(@order.to_gateway_request.merge(:response_url => gateway_response_order_path(@order)))
  end

  # This is the action that the user gets redirected back to after processing
  # via the gateway.  First, the +Order+ is found, and then a new +GatewayResponse+
  # object is created.  Depending upon success or failure, a success page or a 
  # form for resubmission is shown to the user.
  def gateway_response
    @order = Order.find params[:id]
    @response = Braintree::GatewayResponse.new(params)
    @order.update_with_response(@response)
    if @response.is_successful?
      current_user.cart.clear
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

end
