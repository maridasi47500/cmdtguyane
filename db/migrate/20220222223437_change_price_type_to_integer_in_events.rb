class ChangePriceTypeToIntegerInEvents < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :price, :integer
  end
end
