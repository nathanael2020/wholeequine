Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "add_ingredients_for_cart",
                     :insert_after => "[data-hook='product_properties']",
                     :partial => "spree/shared/product_serving"
                     )
