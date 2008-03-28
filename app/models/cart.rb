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

end
