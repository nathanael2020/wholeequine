Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "add_ingredients_table_for_product",
                     :insert_after => "[data-hook='product_properties']",
                     :partial => "spree/shared/product_ingredients",
                     :disabled => false)
