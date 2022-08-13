class Place < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :country, optional: true
  def address
    city.name
  end
end
