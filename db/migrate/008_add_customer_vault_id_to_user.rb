class AddCustomerVaultIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :customer_vault_id, :string
  end

  def self.down
    remove_column :users, :customer_vault_id, :string
  end
end
