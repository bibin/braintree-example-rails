class Order < ActiveRecord::Base
  # ASSOCIATIONS
  belongs_to :user
  has_many :order_items, :dependent => :destroy

  # VALIDATIONS
  validates_uniqueness_of :transactionid, :allow_nil => true

  # CALLBACKS
  before_save :calculate_amount

  def calculate_amount
    self.amount = 0
    self.order_items.each do |order_item|
      self.amount += order_item.total_cost
    end
  end

  def update_with_response(response)
    if response.is_a?(Braintree::GatewayResponse)
      self.update_attributes(response.to_order_attributes)
    end
  end

end
