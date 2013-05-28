module Spree
  class ChartsController < Spree::StoreController
    ssl_allowed :index

    respond_to :html, :js

    def index

      @searcher = Config.searcher_class.new(params)
      @searcher.current_user = try_spree_current_user
      @searcher.current_currency = current_currency
      @products = @searcher.retrieve_products

    end

  end
end
