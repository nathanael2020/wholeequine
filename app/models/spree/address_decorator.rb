Spree::Address.class_eval do
  attr_accessible :position, :name
  after_create :set_position
  scope :order_by_position, ->{ reorder("spree_addresses.position")}
  after_destroy :rebuild_position
  after_create :rebuild_position

  USER_LIMIT = 6

  validates :name, uniqueness: { scope: :user_id }, unless: ->(t){ t.name.blank? }
  def rebuild_position
    user.addresses.order_by_position.each_with_index {|j, pos|
      j.update_column(:position, pos)
    }
  end

  def set_position
    if self.position.to_i == 0
      update_attribute(:position, Spree::Address.maximum(:position) + 1)
    end
  end

  def to_s
    name || super
  end

  class << self
    def user_addresses_for_edit(user, current_address)
      _addresses = user.addresses.order_by_position

      _addresses << primary_address(user) unless _addresses.first
      _addresses << secondary_address(user) unless _addresses.second

      _addresses[current_address.position] = current_address if current_address.present?
      _addresses
    end

    def primary_address(user)
      user.addresses.order_by_position.first ||
        begin
          _addr = Spree::Address.default
          _addr.position =  user.addresses.size
          _addr
        end
    end

    def secondary_address(user)
      if user.addresses.size > 1
        user.addresses.order_by_position.limit(2).last
      else
        _addr = Spree::Address.default
        _addr.position =  user.addresses.size
        _addr
      end
    end

  end
end
