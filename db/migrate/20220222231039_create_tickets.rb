class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :event_id
      t.integer :buyer_id
      t.integer :quantite
      t.string :name
      t.timestamps
    end
    create_table :buyers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :quantite
      t.string :mobile
      t.boolean :bill
      t.timestamps
    end
  end
end
