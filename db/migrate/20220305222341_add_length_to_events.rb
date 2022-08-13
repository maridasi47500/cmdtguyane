class AddLengthToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :length, :time
  end
end
