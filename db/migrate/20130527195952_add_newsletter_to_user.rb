class AddNewsletterToUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :newsletter, :boolean, default: false
  end
end
