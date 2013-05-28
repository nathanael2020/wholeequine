Spree::OrderPopulator.class_eval do
  attr_accessor :last_items

  #
  # Parameters can be passed using the following possible parameter configurations:
  #
  # * Single variant/quantity pairing
  # +:variants => { variant_id => quantity }+
  #
  # * Multiple products at once
  # +:products => { product_id => variant_id, product_id => variant_id }, :quantity => quantity+
  # +:products => { product_id => variant_id, product_id => variant_id }, :quantity => { variant_id => quantity, variant_id => quantity }+
  def populate(from_hash)
    @last_items = []
    from_hash[:products].each do |product_id,variant_id|
      attempt_cart_add(variant_id, from_hash[:quantity])
    end if from_hash[:products]

    from_hash[:variants].each do |variant_id, quantity|
      attempt_cart_add(variant_id, quantity)
    end if from_hash[:variants]

    valid?
  end

  def last_items
    @last_items || []
  end

  private

  def attempt_cart_add(variant_id, quantity)
    quantity = quantity.to_i
    variant = Spree::Variant.find(variant_id)
    if quantity > 0
      if check_stock_levels(variant, quantity)
        @order.add_variant(variant, quantity, currency)
        @last_items ||= []
        @last_items << variant
      end
    end

  end

end
