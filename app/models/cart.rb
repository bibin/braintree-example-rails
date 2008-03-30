class Cart < ActiveRecord::Base
  # ASSOCIATIONS
  belongs_to :user
  has_many :cart_items, :dependent => :destroy

  def total_cost
    total_cost = 0
    self.cart_items.each do |cart_item|
      total_cost += cart_item.total_cost
    end
    return total_cost
  end

  def create_order
    Order.create :order_items => cart_items.map(&:to_order_item)
  end

  # maybe
#  def clear
#    self.cart_items.clear
#  end

end
