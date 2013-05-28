Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "ingredient_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:ingredients, :icon => 'icon-file') %>",
                     :disabled => false)
