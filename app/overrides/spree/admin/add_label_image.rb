Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "product_label_imagefield",
                     :insert_before => "[data-hook='admin_product_form_additional_fields']",
                     :partial => "spree/admin/products/label_image_field",
                     :disabled => false)
