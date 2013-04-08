class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.integer :page_from_id
      t.integer :page_to_id
      t.string :question 

      t.timestamps
    end
  end
end
