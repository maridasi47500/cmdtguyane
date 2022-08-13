class Video < ApplicationRecord
  def datavideo
    link.split('v=')[1]
  end
  def self.findbycode(x)
    where("link like ?","%"+x+"%")[0]
  end
end
