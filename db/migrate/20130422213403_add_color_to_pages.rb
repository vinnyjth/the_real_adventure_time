class AddColorToPages < ActiveRecord::Migration
  def change
    add_column :pages, :color, :string, :null => false, :default => "#2ba6cb"
  end
end
