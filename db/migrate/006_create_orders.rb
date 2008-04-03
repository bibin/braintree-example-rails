class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :orderid
      t.float :amount
      t.string :response
      t.string :responsetext
      t.string :authcode
      t.string :transactionid
      t.string :avsresponse
      t.string :cvvresponse
      t.string :response_code
      t.string :full_response
      t.string :customer_ip
      t.string :status
      t.string :response_hash

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
