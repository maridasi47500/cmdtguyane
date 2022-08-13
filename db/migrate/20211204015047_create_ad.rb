class CreateAd < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.integer :user_id
      t.string :contact_person
      t.string :email
      t.string :phonenumber
      t.string :title
      t.string :category
      t.text :description
      t.string :prix
      t.string :localite
      t.timestamps
    end
  end
end
