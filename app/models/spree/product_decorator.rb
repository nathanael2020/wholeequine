Spree::Product.class_eval do
  attr_accessible :label_image_attributes, :label_image

  has_one :label_image, :as => :viewable, :dependent => :destroy, :class_name => "Spree::Image"
  accepts_nested_attributes_for :label_image, :allow_destroy => true

  def label_image?
    persisted? && label_image.present? && label_image.attachment.present?
  end
  def label_image_url(style = :small)
    label_image.attachment.url(style) if label_image?
  end

  def range_price?(currency)
    _prices = ([ price_in(currency) ] + variants.map{|j| j.price_in(currency) } ).select{|v| v.amount.present? }
    _max_price = _prices.max{|a,b| a.amount <=> b.amount }
    _min_price = _prices.min{|a,b| a.amount <=> b.amount }

    _max_price.amount != _min_price.amount
  end
  def range_price(currency)
    _prices = ([ price_in(currency) ] + variants.map{|j| j.price_in(currency) } ).select{|v| v.amount.present? }

    _max_price = _prices.max{|a,b| a.amount <=> b.amount }
    _min_price = _prices.min{|a,b| a.amount <=> b.amount }

    "#{_min_price.display_price} to #{_max_price.display_price}"
  end
end