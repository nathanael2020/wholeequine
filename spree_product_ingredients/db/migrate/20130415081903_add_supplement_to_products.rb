class AddSupplementToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :is_a_supplement, :boolean, :default => false
  end
end
