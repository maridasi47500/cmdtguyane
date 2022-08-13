class Album < ApplicationRecord
  belongs_to :phototheque
  belongs_to :user
  has_many :photos
end
