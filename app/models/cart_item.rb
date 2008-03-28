class CartItem < ActiveRecord::Base
  # ASSOCIATIONS
  belongs_to :cart
  belongs_to :product

  # VALIDATIONS
  validates_numericality_of :quantity, :product_id, :cart_id

  def total_cost
    self.price * self.quantity
  end
end
