class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :order_id
      t.float :amount
      t.string :response
      t.string :response_text
      t.string :authcode
      t.string :transaction_id
      t.string :gateway_hash
      t.string :avs_response
      t.string :cvv_response
      t.string :response_code
      t.string :gateway_response
      t.string :customer_ip
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
