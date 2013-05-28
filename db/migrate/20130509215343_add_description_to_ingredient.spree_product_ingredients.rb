# This migration comes from spree_product_ingredients (originally 20130420055941)
class AddDescriptionToIngredient < ActiveRecord::Migration
  def change
    add_column :spree_ingredients, :description, :text
  end
end
