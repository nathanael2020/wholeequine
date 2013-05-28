class CreateSpreeProductIngredients < ActiveRecord::Migration
  def change
    create_table :spree_product_ingredients do |t|
      t.integer :product_id
      t.integer :ingredient_id
      t.float :amount_per_serving, :default => 0

      t.timestamps
    end

    add_index :spree_product_ingredients, [:product_id], :name => 'index_spree_products_ingredients_on_product_id'
    add_index :spree_product_ingredients, [:ingredient_id],   :name => 'index_spree_products_ingredients_on_ingredient_id'

  end
end
