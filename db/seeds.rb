Event.destroy_all
Place.destroy_all
event=Event.new do |t|
  t.name = "Audition-concert « Voyage musical au piano »"
  t.url = "/evenements/#{t.name.parameterize}/"
  t.image= "Affiche-web-3.jpg"
  t.price="Gratuit"
  t.priceCurrency="€"
  t.place = Place.new(name: "Auditorium de l'ENCRE",country: Country.find_or_create_by(name: "Guyane Française"), city: City.find_or_create_by(name: "Cayenne", zip: "97300"))
  t.startDate="27 March 2022"
  t.endDate="27 March 2022"
  t.time="18:30"
  t.length="01:30"
end
event.save
event=Event.new do |t|
  t.name = "Audition-concert « Voyage musical au piano »"
  t.url = "/evenements/#{t.name.parameterize}/"
  t.image= "Affiche-web-3.jpg"
  t.price="Gratuit"
  t.priceCurrency="€"
  t.place = Place.new(name: "Auditorium de l'ENCRE",country: Country.find_or_create_by(name: "Guyane Française"), city: City.find_or_create_by(name: "Cayenne", zip: "97300"))
  t.startDate="27 Feb 2022"
  t.endDate="27 Feb 2022"
  t.time="18:30"
end
event.save
event=Event.new do |t|
  t.name = "Audition-concert « Voyage musical au piano »"
  t.url = "/evenements/#{t.name.parameterize}/"
  t.image= "Affiche-web-3.jpg"
  t.price="Gratuit"
  t.priceCurrency="€"
  t.place = Place.new(name: "Auditorium de l'ENCRE",country: Country.find_or_create_by(name: "Guyane Française"), city: City.find_or_create_by(name: "Cayenne", zip: "97300"))
  t.startDate="17 Feb 2022"
  t.endDate="17 Feb 2022"
  t.time="18:30"
end
event.save
event=Event.new do |t|
  t.name = "BIG BAND Ciné concert et ateliers jazz"
  t.url = "/evenements/big-band-cine-concert-et-ateliers-jazz/ "
  t.image= "https://cmdt-guyane.fr/wp-content/uploads/2021/12/Affiche-v1.jpg"
  t.price="Gratuit"
  t.priceCurrency="€"
  t.place = Place.new(name: "Auditorium de l'ENCRE",country: Country.find_or_create_by(name: "Guyane Française"), city: City.find_or_create_by(name: "Cayenne", zip: "97300"))
  t.startDate="2022-02-08"
  t.endDate="2022-02-08"
  t.time="19:30"
end
event.save
event=Event.new do |t|
  t.name = "Cordes sensibles"
  t.url = "/evenements/cordes-sensibles/ "
  t.image= ""
  t.price="Gratuit"
  t.priceCurrency="€"
  t.place = Place.new(name: "Opéra de Toulon",country: Country.find_or_create_by(name: "France"), city: City.find_or_create_by(name: "Toulon", zip: "83000"))
  t.startDate="2022-01-08"
  t.endDate="2022-01-08"
  t.time="21:00"
end
event.save
event=Event.new do |t|
  t.name = "Concert The Australian Pink Floyd Show"
  t.url = "/evenements/"+t.name.parameterize+"/ "
  t.image= "https://agendaculturel.emstorage.fr/the-australian-pink-floyd-show-20201006110314.jpg"
  t.price="45.40"
  t.priceCurrency="€"
  t.description="

Avec plus de 4 millions de billets vendus dans le monde entier, décrit comme Une Référence Absolue par le Times et comme des Rois dans leur genre par le Daily Mirror, The Australian Pink Floyd Show se produit pour la toute première fois en 1988, en Australie. Depuis, le spectacle s'est joué dans plus de 35 pays à travers le monde, ou encore à l'occasion des 50 ans de David Gilmour, allant même jusqu'à accueillir sur scène Rick Wright.
\n

Aujourd'hui TAPFS est, dans son genre, le plus grand show du monde ! The Australian Pink Floyd Show est le premier groupe dédié à Pink Floyd à être sorti des pubs pour envisager une tournée des stades. Le groupe a joué à guichet fermé en Europe, en Angle terre, en Amérique, au Canada, en Amérique du Sud, en Israël ou encore en Russie.
\n

Avec plus de 30 ans d'histoire, The Australian Pink Floyd Show est souvent décrit comme étant le plus beau spectacle hommage de Pink Floyd.
\n

Réservez vos places de concert pour : THE AUSTRALIAN PINK FLOYD SHOW - ZENITH OMEGA
\n

Le prix des places est à partir de : 45.40 €
\n

Date : samedi 23 janvier 2021
\n
Vous disposez par ailleurs du service e-ticket pour imprimer vos billets à domicile dès la fin de commande pour THE AUSTRALIAN PINK FLOYD SHOW.
"
  t.place = Place.new(name: "Zénith Oméga",country: Country.find_or_create_by(name: "France"), city: City.find_or_create_by(name: "Toulon", zip: "83000"))
  t.startDate="2022-02-10"
  t.endDate="2022-02-10"
  t.performer="The Australian Pink Floyd"
  t.time="20:00"
end
event.save
