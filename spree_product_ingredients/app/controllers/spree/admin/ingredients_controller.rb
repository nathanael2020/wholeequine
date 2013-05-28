class Spree::Admin::IngredientsController < Spree::Admin::ResourceController
  def update
    if params[:ingredient][:taxon_ids].present?
      params[:ingredient][:taxon_ids] = params[:ingredient][:taxon_ids].split(',')
    end
    super
  end

end
