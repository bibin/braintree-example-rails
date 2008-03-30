class Order < ActiveRecord::Base
  # ASSOCIATIONS
  belongs_to :user
  has_many :order_items, :dependent => :destroy

  # VALIDATIONS
  validates_uniqueness_of :transaction_id, :allow_nil => true

end
