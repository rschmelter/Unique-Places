class CreateAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :areas do |t|
      t.string :country_name
      t.string :city_name
      t.integer :user_id
    end
  end
end
