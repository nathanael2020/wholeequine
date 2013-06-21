class AddNameToAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :name, :string
    add_index :spree_addresses, :name
  end
  
  end
