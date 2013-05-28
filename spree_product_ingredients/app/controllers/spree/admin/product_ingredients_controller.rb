class Spree::Admin::ProductIngredientsController < Spree::Admin::ResourceController
  belongs_to 'spree/product', :find_by => :permalink
end
