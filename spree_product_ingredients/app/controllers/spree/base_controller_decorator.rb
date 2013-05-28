Spree::BaseController.class_eval do
  helper_method :search_ingredients
  private

  def search_ingredients(q)
    @ingredients = Spree::Ingredient.search(q)
  end

end
