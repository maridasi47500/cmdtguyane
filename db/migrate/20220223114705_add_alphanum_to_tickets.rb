class AddAlphanumToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :clientcode, :string
  end
end
