class Cat < ActiveRecord::Base
  attr_accessible :name, :weight
  belongs_to :user, class_name: 'Spree::User'
  validates :name, presence: true
  validates :weight, :numericality => {:greater_than => 0}

end
