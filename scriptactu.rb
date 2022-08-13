require 'nokogiri'
require 'open-uri'
def updatecat(article,doc2)
    @catel=doc2.css('.cat_post')[0]
  @catlink=@catel.attributes['href'].value.gsub('https://cmdt-guyane.fr','')
  @cattitle=@catel.text.strip.squish
  @cat=Artcat.find_or_create_by(title: @cattitle, url: @catlink)
  
    @catel2=doc2.css('.cat_parent')[0]
    if @catel2
  @catlink2=@catel2.attributes['href'].value.gsub('https://cmdt-guyane.fr','')
  @cattitle2=@catel2.text.strip.squish
  @cat2=Artcat.find_or_create_by(title: @cattitle2, url: @catlink2)
  @cat.update(cat_parent: @cat2)
    end
article.update(artcat: @cat)
end
def myfunc(u)
  @doc=Nokogiri::HTML(URI.open(u))
  @q=@doc.css('.isotope_item')
  @doc.css('article').each do |article|
    @a=article
  @title=article.css('[data-title]')[0].attributes['data-title'].value
  p @title
  @image=article.css('[data-image]')[0].attributes['data-image'].value
  p @image
  @url=article.css('.post_title')[0].children[0].attributes['href'].value
  p @url
  @date=article.css('.post_info_date')[0].children[0].text.to_date
  p @date
  @desc=article.css('.post_descr')[0].text.strip.squish
  p @desc
  begin
  if @url
  @doc2=Nokogiri::HTML(URI.open(@url))
  @auteur=@doc2.css('.post_info_author')[0].text.strip.squish
  p @auteur
  @vues=@doc2.css('.post_counters_number')[0].text.strip.squish
  p @vues
  @content=@doc2.css('.post_content')[0].inner_html
  p @content
    @newdate=@doc2.css('.post_info_date').attributes['content'].value rescue nil
  p @newdate

  @art=Actualite.find_or_create_by(url: @url.gsub('https://cmdt-guyane.fr',''), title: @title, image: @image, date: @newdate, auteur: @auteur, vues: @vues, content: @content)
  #@art=Actualite.find_by(title: @title)
  @art.update(date: @newdate)
  updatecat(@art,@doc2)
  end
  rescue => e1
    p "message2"
    p e1.message

  end
  end
rescue => e
    p "message1"
  p e.message
  
end
url1="https://cmdt-guyane.fr/category/actualites/"
myfunc(url1)
(2..11).to_a.each do |nb|
url="https://cmdt-guyane.fr/category/actualites/page/"+nb.to_s+"/"
myfunc(url)
end


