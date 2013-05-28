Spree::Order.class_eval do

  def ingredient_table
    cell = Struct.new(:item, :product, :ingredient, :product_id )
    @ingredient_table ||= line_items.map{ |j|
      j.product.is_a_supplement? ? j.product.product_ingredients.map{|v| cell.new(j, j.product, v.ingredient, j.product.id) }: nil
    }.flatten.compact.group_by(&:ingredient)
    @ingredient_table
  end

  def ingredient_table_head
    @ingredient_table_head ||= line_items.select{ |j| j.product.is_a_supplement?  }.map(&:product).sort_by(&:id)
  end

  def product_servings(current_currency = nil)
    @product_servings ||= line_items.select{ |j| j.product.serving_options(current_currency).present? }.map(&:product)
  end
end
