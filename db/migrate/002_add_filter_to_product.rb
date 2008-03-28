class AddFilterToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :filter, :string
  end

  def self.down
    remove_column :products, :filter
  end
end
