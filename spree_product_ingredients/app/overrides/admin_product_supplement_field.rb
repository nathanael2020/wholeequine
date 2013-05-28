Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "product_supplement_field",
                     :insert_bottom => "[data-hook='admin_product_form_additional_fields']",
                     :partial => "spree/admin/products/supplement_additional_field",
                     :disabled => false)
