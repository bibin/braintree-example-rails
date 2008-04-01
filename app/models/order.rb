class Order < ActiveRecord::Base
  # ASSOCIATIONS
  belongs_to :user
  has_many :order_items, :dependent => :destroy

  # VALIDATIONS
  validates_uniqueness_of :transaction_id, :allow_nil => true

  # CALLBACKS
  before_save :calculate_amount

  def calculate_amount
    self.amount = 0
    self.order_items.each do |order_item|
      self.amount += order_item.total_cost
    end
  end

end
