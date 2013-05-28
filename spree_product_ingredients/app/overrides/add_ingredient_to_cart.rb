Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :name => "add_ingredients_for_cart",
                     :insert_after => "[data-hook='cart_items']",
                     :partial => "spree/shared/cart_ingredient_button",
                     :disabled => false)
