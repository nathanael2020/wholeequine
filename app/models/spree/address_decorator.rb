Spree::Address.class_eval do
  attr_accessible :position
  after_create :set_position
  scope :order_by_position, ->{ reorder("spree_addresses.position")}
  def set_position
    if self.position.to_i == 0
      update_attribute(:position, Spree::Address.maximum(:position) + 1)
    end
  end

  class << self

    def primary_address(user)
      user.addresses.order_by_position.first || Spree::Address.default
    end

    def secondary_address(user)
      if user.addresses.size > 1
        user.addresses.order_by_position.limit(2).last
      else
        Spree::Address.default
      end
    end

  end
end
