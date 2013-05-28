# This migration comes from spree_product_ingredients (originally 20130415041513)
class CreateSpreeIngredients < ActiveRecord::Migration
  def change
    create_table :spree_ingredients do |t|
      t.string :name
      t.string :unit

      t.timestamps
    end

    create_table :spree_ingredients_taxons, :id => false do |t|
      t.references :ingredient
      t.references :taxon
    end

    add_index :spree_ingredients_taxons, [:ingredient_id], :name => 'index_spree_ingredients_taxons_on_ingredient_id'
    add_index :spree_ingredients_taxons, [:taxon_id],   :name => 'index_spree_ingredients_taxons_on_taxon_id'

  end
end
