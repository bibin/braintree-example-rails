class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name, :permalink
      t.text :description
      t.text :description_html
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
