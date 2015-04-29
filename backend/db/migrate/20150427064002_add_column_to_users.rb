class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :roles, :string
    add_column :users, :level, :integer
    add_column :users, :login_key, :text
  end
end
