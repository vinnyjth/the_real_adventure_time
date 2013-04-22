class AddIndexToForeignKeys < ActiveRecord::Migration
  def change
  	add_index :memberships, [:user_id, :group_id]
  	add_index :pages, [:group_id, :title]
  	add_index :paths, [:page_from_id, :page_to_id]
  	add_index :users, [:name]
  end
end
