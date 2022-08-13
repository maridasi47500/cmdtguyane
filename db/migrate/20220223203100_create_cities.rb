class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |y|
      y.string :name
      y.integer :zip
      y.timestamps
    end
    create_table :countries do |y|
      y.string :name
      y.timestamps
    end
    add_column :places, :city_id, :integer
    add_column :places, :country_id, :integer
  end
end
