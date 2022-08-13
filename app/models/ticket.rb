class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :buyer, optional: true
  alias_attribute :codeclient,:clientcode
  def price
    event.price.to_f
  end
  def billet(nobillet)
    'T'+nobillet.to_s+'E'+clientcode.to_s
  end
  def totalprice
    quantite.to_f * price.to_f
  end

end
