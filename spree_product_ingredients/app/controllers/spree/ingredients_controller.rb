class Spree::IngredientsController < Spree::StoreController
  ssl_allowed :index

  respond_to :html, :js

  def index
    @order = current_order
    respond_with(@order) do |format|
      format.js{ render :partial => "ingredients", :layout => false }
    end
  end

end
