class Ad < ApplicationRecord
  attr_accessor :madesc, :adverts_person, :adverts_email, :adverts_phone, :post_title, :pics, :adverts_price, :adverts_location
  before_validation :myad
  after_validation :emailmyad
  before_validation :myadcreate, only: [:create]
  def emailmyad
    TrocMailer.troc("violon","","sousmarinier@gmail.com",self.title).deliver_now
  rescue
  end
  def categories
    catname = {60 => "Achat", 59 => "Troc", 58 => "Vente"}
    category_ids.map{|x|catname[x.to_i]}
  end
  def category_ids
    category.to_s.split(',')
  end
  def notcategory_ids
    ["60","59","58"].select{|y|!y.in?(category.to_s.split(','))}
  end

  def advert_category=(x)
    write_attribute(:category, x.map(&:to_s).join(','))
  end
  def notverified?
    !verified
  end
  def post_content=(x)
    write_attribute(:description,x)
  end
  def self.mylist(email)
    where(email: email)
  end
  def image
    
  end
  def content
    
  end

  def date
    
  end
  def myad

      self.user_id = nil
      self.contact_person = self.adverts_person if self.adverts_person
      self.email = self.adverts_email if self.adverts_email
      self.phonenumber = self.adverts_phone if self.adverts_phone
      self.title = self.post_title if self.post_title
      self.url = self.post_title.try(:parameterize) if self.post_title
      self.prix = self.adverts_price if self.adverts_price
      self.localite = self.adverts_location if self.adverts_location
    
  end
  def myadcreate
    self.expires = Date.today+30.days
  end
  def updateexpires
    expires = self.created_at+30.days
    save
  end
  def self.findby(query,location)
    q='%'+query.downcase.gsub(' ','%')+'%' rescue ''
    l='%'+location.downcase.gsub(' ','%')+'%' rescue ''
    if l == '' && q == ''
      []
    else
    where(["lower(description) like ? or lower(contact_person) like ? or lower(title) like ? and lower(localite) like ? and publish = '1' ",q,q,q,l])
    end
  end
end
