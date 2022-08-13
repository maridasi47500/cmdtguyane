class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :your_name
      t.string :your_email
      t.string :your_subject
      t.string :your_message
    end
  end
end
