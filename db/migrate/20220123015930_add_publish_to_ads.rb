class AddPublishToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :publish, :boolean
  end
end
