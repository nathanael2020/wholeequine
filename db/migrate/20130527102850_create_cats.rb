class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.float :weight
      t.integer :user_id
      t.timestamps
    end

    create_table :users_cats do |t|
      t.references :user
      t.references :cat
    end
  end
end
