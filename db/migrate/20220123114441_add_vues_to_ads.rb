class AddVuesToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :vues, :integer
  end
end
