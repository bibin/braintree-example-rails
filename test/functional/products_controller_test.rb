require File.dirname(__FILE__) + '/../test_helper'
require 'products_controller'

# Re-raise errors caught by the controller.
class ProductsController; def rescue_action(e) raise e end; end

class ProductsControllerTest < ActionController::TestCase

  def setup
    @controller = ProductsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  # INDEX
  def test_should_assign_variable_on_index
    get :index
    assert assigns(:products)
  end

  def test_should_render_template_on_index
    get :index
    assert_template "index"
  end

  def test_should_have_header_on_index
    get :index
    assert_tag :tag => "h1", :content => "Products"
  end

  # NEW
  def test_should_assign_variable_on_new
    login_as :admin
    get :new
    assert assigns(:product)
  end

  def test_should_render_template_on_new
    login_as :admin
    get :new
    assert_template "new"
  end

  def test_should_have_form_on_new
    login_as :admin
    get :new
    assert_tag :form, :attributes => { :action => products_path }
  end

  # CREATE
  def test_should_assign_variable_on_create
    login_as :admin
    post :create, :product => valid_product_attributes
    assert assigns(:product)
  end

  def test_should_create_new_product_with_post
    login_as :admin
    assert_difference 'Product.count' do 
      post :create, :product => valid_product_attributes
    end
  end

  def test_should_redirect_if_success_on_create
    login_as :admin
    post :create, :product => valid_product_attributes
    assert_redirected_to products_path
  end

  def test_should_have_flash_if_success_on_create
    login_as :admin
    post :create, :product => valid_product_attributes
    assert !flash.empty?
  end

  def test_should_render_form_with_validation_errors
    login_as :admin
    post :create, :product => valid_product_attributes(:name => nil)
    assert_template "new"
  end

  # EDIT
  def test_should_assign_variable_on_edit
    login_as :admin
    get :edit, :id => products(:first)
    assert assigns(:product)
  end

  def test_should_render_template_on_edit
    login_as :admin
    get :edit, :id => products(:first)
    assert_template "edit"
  end
  
  def test_should_have_form_on_edit
    login_as :admin
    get :edit, :id => products(:first)
    assert_tag :form, 
               :attributes => { :action => product_path(products(:first)) }
  end

  # UPDATE
  def test_should_assign_variable_on_update
    login_as :admin
    put :update, :id => products(:first), 
        :product => products(:first).attributes
    assert assigns(:product)
  end

  def test_should_update_attributes_on_update
    # FIXME: this test doesn't work
#    assert_difference "Product.find(#{products(:first)}).name" do 
#      put :update, :id => products(:first),
#          :product => products(:first).attributes.merge(:name => "new name")
#    end
  end

  def test_should_assign_flash_if_success_on_update
    login_as :admin
    put :update, :id => products(:first), 
        :product => products(:first).attributes
    assert !flash.empty?
  end

  def test_should_redirect_if_success_on_update
    login_as :admin
    put :update, :id => products(:first), 
        :product => products(:first).attributes
    assert_redirected_to product_path(products(:first))
  end

  def test_should_render_edit_form_with_validation_errors
    login_as :admin
    put :update, :id => products(:first), 
        :product => products(:first).attributes.merge(:name => nil)
    assert_template "edit"
  end

  # SHOW
  def test_should_assign_variables_on_show
    get :show, :id => products(:first)
    assert assigns(:product)
  end

  def test_should_render_template_on_show
    get :show, :id => products(:first)
    assert_template "show"
  end

  def test_should_have_button_to_add_product_to_cart
    # TODO: write a test for this button
  end

  # DESTROY
  def test_should_delete_product_on_delete
    # FIXME: this test doesn't work
#    assert_difference 'Product.count' do 
#      delete :destroy, :id => products(:first)
#    end
  end

  def test_should_flash_if_success_on_destroy
    login_as :admin
    delete :destroy, :id => products(:first)
    assert !flash.empty?
  end

  def test_should_redirect_if_success_on_destroy
    login_as :admin
    delete :destroy, :id => products(:first)
    assert_redirected_to products_path
  end

  private
  def valid_product_attributes(options = { })
    { :name => "Product", :description => "This is a description.",
      :filter => "textile_filter", :price => 10.00 }.merge(options)
  end

end
