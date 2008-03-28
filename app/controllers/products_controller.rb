class ProductsController < ApplicationController

  before_filter :admin_login_required, :except => [ :index, :show ]

  def index
    @products = Product.find :all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Product saved."
      redirect_to products_path
    else
      render :action => "new"
    end
  end

  def show
    @product = Product.find params[:id]
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product has been updated."
      redirect_to product_path(@product)
    else
      render :action => "edit"
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:notice] = "Product has been deleted."
    redirect_to products_path
  end
end

