class OrderItem < ActiveRecord::Base
  # ASSOCIATIONS
  belongs_to :order
  belongs_to :product

  # VALIDATIONS
  validates_numericality_of :quantity, :product_id

  def total_cost
    self.price * self.quantity
  end
end
