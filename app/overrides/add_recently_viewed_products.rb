Deface::Override.new(:virtual_path => 'spree/home/index',
                     :name => 'add_recently_viewed_products_to_home_index',
                     :insert_after => "#index[data-hook], [data-hook='homepage_sidebar_navigation']",
                     :partial => 'spree/shared/recently_viewed_products',
                     :disabled => false)
                     
Deface::Override.new(:virtual_path => 'spree/products/index',
                     :name => 'add_recently_viewed_products_to_products_index',
                     :insert_after => "#index[data-hook], [data-hook='homepage_sidebar_navigation']",
                     :partial => 'spree/shared/recently_viewed_products',
                     :disabled => false)

Deface::Override.new(:virtual_path => 'spree/shared/_products',
                     :name => 'add_recently_viewed_products_to_products_index',
                     :insert_after => "#products[data-hook], [data-hook='products']",
                     :partial => 'spree/shared/recently_viewed_products',
                     :disabled => true)
                     
Deface::Override.new(:virtual_path => 'spree/products/show',
                     :name => 'add_recently_viewed_products_to_products_show',
                     :insert_after => "#product_description[data-hook], [data-hook='product_description']",
                     :partial => 'spree/shared/recently_viewed_products',
                     :disabled => true)