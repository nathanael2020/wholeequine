class AddOrderlinessToAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :position, :integer, default: 0
  end
end
