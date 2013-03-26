class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :name
      t.boolean :male
      t.integer :route

      t.timestamps
    end
  end
end
