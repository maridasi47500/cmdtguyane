class Phototheque < ApplicationRecord
  has_many :albums
  def self.findmy(a1,a2)
    where('title like ?',"%#{a1}%#{a2}%")[0]
  end
  def shorttitle
    title.split('–')[1].strip || title rescue title
  end
end

