class Article < ApplicationRecord
  belongs_to :artcat, optional: true
  attr_accessor :modals
  def self.allmyarticles(s = "", i = "")
    k=self.quelquesactualites(s).each_slice(10).to_a.to_a
    j=i.to_i == 0 ? k[0].to_a : k[(i.to_i - 1)]
    j
  end
  def self.allmynewsarticles(s = "", i = "")
    k=self.mesactualites(s).each_slice(10).to_a.to_a
    j=i.to_i == 0 ? k[0].to_a : k[(i.to_i - 1)]
    j
  end
  def self.latestnews
    self.mesactualites("")[0..2]
  end
  def self.myarticles(s, i)
    k=self.quelquesactualites(s.to_s).each_slice(10).to_a.to_a
    j=i.to_i == 0 ? k[0].to_a : k[(i.to_i - 1)]
    j

  end
  def self.mynewsarticles(s, i)
    k=self.mesactualites(s.to_s).each_slice(10).to_a.to_a
    j=i.to_i == 0 ? k[0].to_a : k[(i.to_i - 1)]
    j

  end
  def locallinks
    self.content=self.content.gsub('https://cmdt-guyane.fr/','')
    self.content=self.content.gsub('action=','actions=')
    self
  end
  def self.nbpages(t,text=nil)
    k=quelquesactualites(text).each_slice(10).to_a.length
  end
  def self.lastpage(t,text=nil)
    j=self.nbpages(t,text)
    "#{j} - #{j}"
  end
  def self.dotpages(t,text=nil)
    k=select('*').mypages(t.to_s,text.to_s).each_slice(10).to_a.length
    nb=(1..(k)).to_a
    current=nb.index(t.to_i).to_i
    nbp=self.nbpages(t,text)
    if nb[(current + 2)]
    nb[(current + 2)..(current + 2)] - [nbp]
    else
      []
    end
  end
  
  def self.quelquesactualites(text)
    (Ad.findby(text.to_s,text.to_s).to_a+select('*').order(date: :desc).findby(text.to_s).to_a).sort {|a,b|a.created_at <=> b.created_at}
  end
  def self.mypages(text, t)
    k=quelquesactualites(text).each_slice(10).to_a.each_slice(10).to_a
    nb=k.map.with_index {|y, i| [i, y.length]}
    nb
  end
  def self.mesactualites(text)
    (select('*').order(date: :desc).findby(text.to_s).to_a).sort {|a,b|a.created_at <=> b.created_at}
  end

  def self.mynewspages(text, t)
    k=mesactualites(text).each_slice(10).to_a.each_slice(10).to_a
    nb=k.map.with_index {|y, i| [i, y.length]}
    nb
  end

  def self.pages(t)
  end
  def self.findbytitle(t)
    select("replace(articles.url, '-','') as url1, articles.*").group('articles.id').having('url1 like ?', '%'+t.gsub('-','')+'%')[0]
  end
  def self.findbytheurl(s)
    k='%'+s.downcase.gsub(' ','%')+'%'

    where('lower(articles.url) like ?', k)[0]
  end
  def locallink
    write_attribute(:content, self.content.gsub("https://cmdt-guyane.fr",""))
    self
  end
  def locallinksaison
    write_attribute(:content, self.content.gsub("https://cmdt-guyane.fr",""))
    self
  end

  def self.findbythetitle(s)
    k='%'+s.downcase.gsub(' ','%')+'%'

    where('lower(articles.title) like ? or lower(articles.url) like ?', k,k)[0].becomes(Post)
  end
    def self.findbyexacturl(s)
    k='%'+s.downcase.gsub(' ','%')+'/'

    where('lower(articles.url) like ?', k)[0].becomes(Post)
  end
  def self.findby(s)
    k='%'+s.to_s.downcase.gsub(' ','%')+'%'

    where('lower(articles.title) like ? or lower(articles.content) like ? or lower(articles.url) like ?', k, k,k)
  end
  def self.search(s)
    k='%'+s.downcase.gsub(' ','%')+'%'

    where('lower(articles.title) like ? or lower(articles.content) like ?', k,k)
  end
  def currentcat
    Artcat.new(title: self.title, url: self.url)
  end

end
