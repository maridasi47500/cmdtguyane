require 'nokogiri'
require 'open-uri'
#Post.destroy_all
@urls=[
#  "https://cmdt-guyane.fr/vie-scolaire/",
#  "https://cmdt-guyane.fr/edgar-nibul/",
#  "https://cmdt-guyane.fr/localisation/",
#  "https://cmdt-guyane.fr/historique/",
#  "https://cmdt-guyane.fr/evenements/",
#  "https://cmdt-guyane.fr/mediatheque/",
#  "https://cmdt-guyane.fr/videotheque/",
#  "https://cmdt-guyane.fr/phototheque/",
#  "https://cmdt-guyane.fr/personnel-enseignant/",
#  "https://cmdt-guyane.fr/organigramme/",
#  "https://cmdt-guyane.fr/versions-telechargeables/",
#  "https://cmdt-guyane.fr/le-logo/",
#  "https://cmdt-guyane.fr/postuler-au-cmdtg/",
#  "https://cmdt-guyane.fr/le-conseil-dadministration/",
#  "https://cmdt-guyane.fr/inscriptions-re-inscriptions-2020-2021/",
#  "https://cmdt-guyane.fr/les-disciplines-2/",
#  "https://cmdt-guyane.fr/les-departements-du-cmdtg/",
#  "https://cmdt-guyane.fr/musique/",
#  "https://cmdt-guyane.fr/les-cursus-du-cmdtg/",
#  "https://cmdt-guyane.fr/danse/",
#  "https://cmdt-guyane.fr/les-cursus/",
#  "https://cmdt-guyane.fr/le-cursus-de-formation/",
#  "https://cmdt-guyane.fr/reglement-interieur-des-eleves/",
#  "https://cmdt-guyane.fr/projet-detablissement/",
#  "https://cmdt-guyane.fr/le-reglement-des-etudes/",
#  "https://cmdt-guyane.fr/mon-compte/",
#  "https://cmdt-guyane.fr/espace-acheteur/",
#  "https://cmdt-guyane.fr/louer-un-instrument/",
#  "https://cmdt-guyane.fr/espace-vendeur/",
#  "https://cmdt-guyane.fr/louer-une-salle/",
#  "https://cmdt-guyane.fr/le-cmdtg/"
"https://cmdt-guyane.fr/evenements/"

]

@urls.each do |url|
@doc=Nokogiri::HTML(URI.open(url))
@content=@doc.css('.post_content').inner_html
@title=@doc.css('.page_title').text rescue nil
@date=@doc.css('.post_info_date')[0].attributes['content'].value rescue nil
@auteur=@doc.css('.post_info_author').text rescue nil
@vues=@doc.css('.post_counters_number').text rescue nil
  @catel=@doc.css('.cat_post')[0]
  @catlink=@catel.attributes['href'].value.gsub('https://cmdt-guyane.fr','') rescue nil
  @cattitle=@catel.text.strip.squish rescue nil
  @cat=Artcat.find_or_create_by(title: @cattitle, url: @catlink)
  
    @catel2=@doc.css('.cat_parent')[0]
    if @catel2
  @catlink2=@catel2.attributes['href'].value.gsub('https://cmdt-guyane.fr','') rescue nil
  @cattitle2=@catel2.text.strip.squish rescue nil
  @cat2=Artcat.find_or_create_by(title: @cattitle2, url: @catlink2)
  @cat.update(cat_parent: @cat2)
    end

@post=Post.find_or_create_by(url: url.gsub('https://cmdt-guyane.fr',''), title: @title, auteur: @auteur,vues: @vues, date: @date, content:@content, artcat: @cat)
rescue => e
  p "erreur1"
  p e.message
end
#CREER UNE ACTUALITE
@urls=[
  "https://cmdt-guyane.fr/personnel-administratif-et-technique/"
]

@urls.each do |url|
@doc=Nokogiri::HTML(URI.open(url))
@content=@doc.css('.post_content').inner_html
@title=@doc.css('.page_title').text
@date=@doc.css('.post_info_date')[0].attributes['content'].value
@auteur=@doc.css('.post_info_author').text
@vues=@doc.css('.post_counters_number').text
  @catel=@doc.css('.cat_post')[0]
  @catlink=@catel.attributes['href'].value.gsub('https://cmdt-guyane.fr','')
  @cattitle=@catel.text.strip.squish
  @cat=Artcat.find_or_create_by(title: @cattitle, url: @catlink)
  
    @catel2=@doc.css('.cat_parent')[0]
    if @catel2
  @catlink2=@catel2.attributes['href'].value.gsub('https://cmdt-guyane.fr','')
  @cattitle2=@catel2.text.strip.squish
  @cat2=Artcat.find_or_create_by(title: @cattitle2, url: @catlink2)
  @cat.update(cat_parent: @cat2)
    end

@post=Actualite.find_or_create_by(url: url.gsub('https://cmdt-guyane.fr',''), title: @title, auteur: @auteur,vues: @vues, date: @date, content:@content, artcat: @cat)
 
end
