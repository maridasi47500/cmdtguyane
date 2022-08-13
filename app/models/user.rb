class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def log=(l)
    write_attribute(:email, l)
  end
  def pwd=(p)
    self.password=p
  end
  def self.findby(a)
    k=a.values
    u=User.find_by(email: k[0])
    if u && u.valid_password?(k[1])
      u
    else
      nil
    end
  end

end
