
Spree::ProductsController.class_eval do
	
    before_filter :load_product, :only => :show
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404

	helper 'spree/taxons'

	
    def index

		@taxons = Spree::Taxon.roots
	  @searcher = Spree::Config.searcher_class.new(params)
      @searcher.current_user = try_spree_current_user
      @searcher.current_currency = current_currency
      @products = @searcher.retrieve_products


    end

end
