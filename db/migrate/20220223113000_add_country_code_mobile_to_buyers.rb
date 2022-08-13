class AddCountryCodeMobileToBuyers < ActiveRecord::Migration[6.0]
  def change
    add_column :buyers, :country_code, :integer
  end
end
