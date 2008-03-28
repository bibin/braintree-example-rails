class CartsController < ApplicationController

  before_filter :login_required
  before_filter :find_or_create_cart

  # renders show.html.erb
  def show
  end

  
  def add
    @product = Product.find params[:product_id]
    @cart_item = @cart.cart_items.build params[:cart_item]
    @cart_item.product, @cart_item.price = @product, @product.price
    if @cart_item.save
      flash[:notice] = "#{@product.name} was added to your cart."
    else
      flash[:error] = "Product could not be saved for some reason."
    end
    redirect_to product_path(@product)
  end

  def update
  end

  def remove
  end

  def clear
    @cart.cart_items.clear
    flash[:notice] = "Your cart has been cleared."
    redirect_to :action => "show"
  end

  private
  def find_or_create_cart
    @cart = Cart.find_or_create_by_user_id(:user_id => current_user)
  end

end
