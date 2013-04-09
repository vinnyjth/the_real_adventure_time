class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :content
      t.string :stamp
      t.string :title
      t.integer :group_id

      t.timestamps
    end
  end
end
