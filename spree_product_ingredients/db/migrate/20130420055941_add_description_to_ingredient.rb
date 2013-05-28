class AddDescriptionToIngredient < ActiveRecord::Migration
  def change
    add_column :spree_ingredients, :description, :text
  end
end
