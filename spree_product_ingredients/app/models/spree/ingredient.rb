class Spree::Ingredient < ActiveRecord::Base
  attr_accessible :name, :unit, :taxon_ids, :description
  validates :name, :unit, presence: true

  has_and_belongs_to_many :taxons, :join_table => 'spree_ingredients_taxons'
  has_many :product_ingredients

  def display_name
    "#{name} (#{unit}),  tx: #{taxons.map(&:pretty_name).join(', ')} "
  end

  class << self

    def search(q)
      return [] if q.blank?
      like_sql = arel_table[:name].matches("%#{q}%").or(arel_table[:description].matches("%#{q}%"))
      where(like_sql)
    end

    def search_product_ids(queries = [])
      queries = [queries].compact.map(&:split).flatten.compact
      return nil if queries.blank?

      like_sql = Spree::Ingredient.arel_table[:name].matches("%#{queries.shift}%")
      queries.each do |q|
        like_sql = like_sql.or(Spree::Ingredient.arel_table[:name].matches("%#{q}%"))
      end

      joins(:product_ingredients).where(like_sql).select("spree_product_ingredients.product_id")
    end
  end

end
