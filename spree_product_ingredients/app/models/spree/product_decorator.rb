Spree::Product.class_eval do
  has_many :product_ingredients
  attr_accessible :is_a_supplement
  scope :supplement, where(:is_a_supplement =>true)

  def amount_ingredient(ingredient)
    product_ingredients.select{|j| j.ingredient == ingredient }.map{|v| v.amount_per_serving.to_f }.sum
  end

  def serving_display(current_currency = nil)
    res = serving_options(current_currency).map{|j| j.count.to_i }
    max, min = res.max, res.min
    if max == min
      max.to_s
    else
      "#{min} to #{max}"
    end
  end


  def price_per_serving_display(current_currency = nil)

    res_price = serving_options(current_currency).map{|j| j.price }
    res_count = serving_options(current_currency).map{|j| j.count.to_i }
    max_price, min_price = res_price.max, res_price.min
    max_count, min_count = res_count.max, res_count.min

    if max_price == min_price
      "$#{(max_price / max_count).round(2)}"
    else
      "$#{(min_price / min_count.to_f).round(2) } to $#{ (max_price / max_count.to_f).round(2) }"
    end
  rescue
    nil
  end

  def serving_options(current_currency = nil)
    return @servings if @servings.present?

    @servings = []
    @serving = Struct.new(:count, :price)
    variants.active(current_currency).each do |v|
      if (option_values = v.option_values.select{ |v| v.option_type.name == Spree::OptionType::SERVING_NAME }).present?
        option_values.each do |op|
          @servings << @serving.new(op.name, v.price)
        end
      end
    end

    @servings
  end

  class << self
    def ingredients_table(products)
      cell = Struct.new(:product, :ingredient, :product_id, :taxon_ids, :product_ingredients )
      products.map{|j|
        j.product_ingredients.map{|v| cell.new(j, v.ingredient, j.id, j.taxon_ids, j.product_ingredients ) }
      }.flatten.compact.group_by(&:ingredient)
    end
  end
  def as_json(*args)
    obj = super(*args)
    obj['product'].merge({:taxon_ids => self.taxon_ids})
  end
end