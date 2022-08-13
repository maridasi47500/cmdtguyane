class AddExpiredToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :expires, :date
  end
end
