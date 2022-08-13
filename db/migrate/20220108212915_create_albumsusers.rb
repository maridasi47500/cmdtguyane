class CreateAlbumsusers < ActiveRecord::Migration[6.0]
  def change
    create_table :phototheques do |t|
      t.string :title
      t.timestamps
    end
    create_table :albums do |t|
      t.integer :phototheque_id
      t.integer :user_id
      t.string :title
      t.integer :vues
      t.timestamps
    end
    create_table :photos do |t|
      t.integer :album_id
      t.string :title
      t.string :image
      t.timestamps
    end
    create_table :users do |t|
      t.string :username
      t.string :image
      t.timestamps
    end
  end
end
