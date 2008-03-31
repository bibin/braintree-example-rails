require 'digest/md5'
class OrdersController < ApplicationController
  
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

  def checkout
    @order = Order.find params[:id]
    prepare_hash_variables
    create_hash_from_variables
  end

  def status

  end

  private
  def prepare_hash_variables
    @time = Time.now.getutc.strftime("%Y%m%d%H%M%S")
    @key = "Zydpf74pK59Gc85vpu6r9My286BUYw3q"
    @key_id = "557218"
  end

  def create_hash_from_variables
    @string_to_hash = [@order.id, @order.amount, @time, @key].join("|")
    @tr_hash = Digest::MD5.hexdigest(@string_to_hash)
  end
end
