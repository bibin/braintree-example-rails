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

  # Takes a response hash from a +Braintree::GatewayResponse+ object and
  # updates the necessary attributes.
  def update_with_response(response)
    if response.is_a?(Braintree::GatewayResponse)
      self.update_attributes(response.to_order_attributes)
    end
  end
  
  # Call @order.to_gateway_request to generate valid instance variables to use in the 
  # checkout order form.
  def to_gateway_request
    { :orderid => self.id, :amount => self.amount, :type => self.gateway_request_type }
  end

  # This will eventually be hooked up to acts_as_state machine to determine
  # what the exact value is.  For now, all orders are 'sale'.
  def gateway_request_type
    "sale" if self.status.blank?
  end

end
