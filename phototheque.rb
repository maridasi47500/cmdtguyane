require 'nokogiri'
require 'open-uri'

@docphoto=Nokogiri::HTML(URI.open("https://cmdt-guyane.fr/phototheque/"))
@urlphototheques=@docphoto.css('.vc_btn3-size-md').map{|x|x.attributes['href'].value}
@urlphototheques.each do |phototheque_url|
@doc=Nokogiri::HTML(URI.open(phototheque_url))
@phototheque=Phototheque.find_or_create_by(title: @doc.css('.page_title').text)

@doc.css('.vc_column-inner').each do |album|
@album=album.children[0].children[1].children[1].children[1].attributes['href'].value
@searchalbumtitle=album
@albumtitle=@searchalbumtitle.children[0].children[1].children[1].children[1].children[0].attributes['alt'].value


@doc2=Nokogiri::HTML(URI.open(@album))
@doc2.css('.album-header-content').each do |photoalbum|
  @photoalbum=photoalbum
@photourl="https:"+photoalbum.attributes['style'].value.split("background-image: url(")[1].gsub(");","")
#@title=@photoalbum.children[5].children[0].children[1].children[0].text.strip
@photocount=@photoalbum.children[7].children[0].children[1].children[0].text
@views=@photoalbum.children[7].children[0].children[5].children[0].text
@photouser="https:"+@photoalbum.children[13].children[1].attributes['style'].value.split("background-image: url(")[1].gsub(");","")
@username=@photoalbum.children[13].children[3].children[1].children[0].text

@myuser=User.find_or_create_by(username: @username, image: @photouser)
@myalbum=@phototheque.albums.find_or_create_by(title: @albumtitle, user: @myuser,vues: @views)
#####
#photo-list-photo-view
rescue => e
  p "erreur 1"
  p e.message
end
if @myalbum
@doc2.css('.photo-list-photo-view').each do |photoalbum|
  @myphotoalbum=photoalbum
  @imagephoto='https:'+photoalbum.attributes['style'].value.split("background-image: url(")[1].gsub(')','')
  @titrephoto=photoalbum.css('.title')[0].text rescue nil
  @myphoto = @myalbum.photos.find_or_create_by(title: @titrephoto,image: @imagephoto)
rescue => e
  p "erreur 2"
  p e.message
end
end


rescue
end
end


