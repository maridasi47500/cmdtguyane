require 'nokogiri'
require 'open-uri'

@doc=Nokogiri::HTML(File.open("/home/mary/mespagewebv/Vidéothèque – Conservatoire de Musique, Danse et Théâtre de Guyane.html"))


@doc.css('[data-yrc-size="small"]').each do |y|
  img=y.attributes['src'].value.gsub("Vid%C3%A9oth%C3%A8que%20%E2%80%93%20Conservatoire%20de%20Musique,%20Danse%20et%20Th%C3%A9%C3%A2tre%20de%20Guyane_fichiers/","") rescue nil
  
  @vid=Video.find_or_create_by(title: y.parent.attributes['title'].value, link: y.parent.attributes['href'].value)
  p img
  @vid.update(image: img)
end
