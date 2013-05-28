class AddCustomFieldsToUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :first_name, :string
    add_column :spree_users, :last_name, :string
    add_column :spree_users, :phone, :string
    add_column :spree_users, :health_issues, :string
    add_column :spree_users, :fitness_goals, :string
    add_column :spree_users, :fitness_routines, :string
  end
end
