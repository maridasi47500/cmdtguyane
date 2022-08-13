class AddVerifiedToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :verified, :boolean
  end
end
