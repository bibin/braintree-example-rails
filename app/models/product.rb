class Product < ActiveRecord::Base
  # VALIDATIONS
  validates_presence_of :name, :description
  validates_length_of :name, :in => 1..255
  validates_numericality_of :price

  # PERAMLINK_FU
  has_permalink :name

  # FILTERED_COLUMN
  filtered_column :description

  # ASSOCIATIONS
  has_many :cart_items, :dependent => :destroy
  has_many :order_items, :dependent => :destroy

  def to_param
    "#{self.id}-#{self.permalink}"
  end
end
