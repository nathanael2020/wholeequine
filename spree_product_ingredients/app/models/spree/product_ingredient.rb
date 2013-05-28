class Spree::ProductIngredient < ActiveRecord::Base
  attr_accessible :ingredient_id, :product_id, :amount_per_serving
  belongs_to :product
  belongs_to :ingredient

  validates :product_id, :ingredient_id, :amount_per_serving, presence: true
  delegate :name, :description, :to => :ingredient, :prefix => true
  def pretty_amount
    "#{amount_per_serving} #{ingredient.unit}"
  end
end
