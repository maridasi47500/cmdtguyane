class Artcat < ApplicationRecord
  has_many :articles
  has_many :actualites
  has_many :posts
  belongs_to :cat_parent, class_name: "Artcat", optional: true, foreign_key: "cat_parent_id"
  has_many :cat_children, class_name: "Artcat", foreign_key: "cat_parent_id"
  has_many :otherposts, through: :cat_parent, source: :posts 
  has_many :otherotherposts, through: :cat_children, source: :posts 
  has_many :otherarticles, through: :cat_parent, source: :articles 
  has_many :otherotherarticles, through: :cat_children, source: :articles 

  def self.findbytitle(t)
    k = '%'+t.gsub(' ','%')+'%'
    where('title like ?',k)[0]
  end
  def self.findbyurl(t)
    k = '%'+t.gsub(' ','%')+'%'
    where('url like ?',k)[0]
  end
  def allotherposts
    articles + otherotherarticles
  end

end
