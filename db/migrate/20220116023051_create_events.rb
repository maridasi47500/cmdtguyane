class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :type
      t.string :name
      t.string :image
      t.string :address
      t.timestamps
    end
    create_table :events do |t|
      t.string :name
      t.string :url
      t.string :performer
      t.text :description
      t.date :startDate 
      t.date :endDate 
      t.string :date
      t.string :image
      t.string :price
      t.string :priceCurrency
      t.integer :place_id
      t.time :time
      t.timestamps
    end
  end
end
