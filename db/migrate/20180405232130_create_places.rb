class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :type
      t.string :description
      t.integer :area_id
    end
  end
end
