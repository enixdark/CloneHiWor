class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      # t.references :user, index: true, foreign_key: true
      t.integer :parent_id
      t.string :controllers
      t.string :action
      t.integer :display_order

      t.timestamps null: false
    end
  end
end
