class AddNameToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :name, :text
  end
end
