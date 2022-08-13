require 'securerandom'
require 'open-uri'

class Event < ApplicationRecord

  belongs_to :place
  has_one :city, through: :place, source: :city
  has_one :country, through: :place, source: :country
  has_many :tickets, autosave: true
  has_many :buyers, through: :tickets, source: :buyer, autosave: true
  attr_accessor :country_code,:mybuyer, :myticketid, :quantite,:current_url, :current_step, :widgetState, :wsid, :recapTickets, :start_date, :champs_3_0, :champs_2_0, :champs_5_0, :champs_36_0, :champs_7_0, :facturation_societe, :facturation_tva_intra, :facturation_adresse, :facturation_cp, :facturation_ville, :facturation_pays, :facturation_info, :id_evenement, :locale, :code, :color_primary, :facturation, :accepte_cgv,:seatsToken, :montantBilletInitial_0, :id_code_cpt_0, :quantite_initiale_min, :quantite_initiale, :chps_montant_0, :cpt_chps, :group_size, :aff_ht, :aff_comm, :chps_montant_final, :chps_spb_amount_total_ttc, :chps_spb_count_charged_tickets, :nbCodeUsed
  before_validation :mycurrentstep
validates_acceptance_of :accepte_cgv, accept: ["1", true], allow_nil: false, unless: -> { !recapTickets }
  def lieuevent

[self.place.try(:name), self.place.name,self.place.try(:zipcode), self.city.try(:name)].select{|h|h}.join(' | ')
end


  def createticket
  self.tickets.create(quantite: 0, name: "invitation")
  end
  def endtime
    time+length
  end
  def fulladdress
    city.try(:zip).to_s+" "+city.try(:name)
  end
  def self.mycolumns(h)
                  {"firstname"=>"champs_3_0",
              "lastname"=>"champs_2_0",
              "email"=> "champs_5_0",
              "mobile"=>"champs_7_0",
              "bill"=> "facturation"}[h.to_s] || h

  end
    def self.mycolumnnames
                  {"firstname"=>"champs_3_0",
              "lastname"=>"champs_2_0",
              "email"=> "champs_5_0",
              "mobile"=>"champs_7_0",
              "bill"=> "facturation"}

  end

  def mycurrentstep
    case current_step.to_s
    when "tickets"
      ticket = self.tickets.find(self.id_code_cpt_0)
      self.myticketid=ticket.id
      ticket.update(quantite: quantite)
    when "form"
      ticketid = JSON.parse(recapTickets)[0]['id']
      p "ticket id ", ticketid
            self.myticketid=ticketid
            ticket=self.tickets.find(ticketid)
            begin
            self.tickets.find(ticketid).buyer =self.mybuyer= Buyer.new do |b|
              b.firstname=champs_3_0
              b.lastname=champs_2_0
              b.email=champs_5_0
              b.mobile=champs_7_0
              b.country_code=country_code.to_i
              b.bill= facturation == "on"
            end
            rescue
            end
            if !(champs_5_0.length > 0 && champs_5_0 == champs_36_0)
              self.errors.add(:champs_5_0,"doivent être identiques")
              self.errors.add(:champs_36_0,"doivent être identiques")

            end
            begin
            p self.mybuyer
            p self.mybuyer.valid?
                        p self.mybuyer.errors.messages
                        self.mybuyer.save

            rescue
            end
            begin
              p "securecode"
            str=13.times.map { rand(0..9) }.join.to_s.upcase rescue nil
            p str
            l=self.tickets.find(self.myticketid)
            l.clientcode= str
             l.save
             p l.errors
            rescue => e
              p e.message
            end

p self.tickets.find(self.myticketid).errors
p self.tickets.find(self.myticketid), "myticket!!"


    end
  end
  def commande(tid)
    'C'+(tickets.where("id <= ?", tid).count).to_s+'E'+Ticket.find(tid).clientcode.to_s
  end

  def myrange(tid)
    (self.tickets.where("id < ?", tid).sum(:quantite).to_i + 1)..(self.tickets.where("id <= ?", tid).sum(:quantite).to_i )
  end
  def self.many?(date)
    where("startDate = ? or endDate = ?",date, date).count > 0
  end
  def self.manyexpired?(date)
    where("startDate = ? or endDate = ?",date, date).select {|h| h.expired?}.length > 0
  end
  def price=(x)
    l=x == "Gratuit" ? 0 : x.to_i
    write_attribute(:price, l)

  end
  def price
    l=read_attribute(:price)
    l.to_i == 0 ? "Gratuit" : l.to_i
  end

  def self.many(date)
    where("startDate = ? or endDate = ?",date, date)
  end
  def self.findbytitle(s)
    k='%'+s.downcase.gsub(' ','%')+'%'

    where('lower(url) like ?', k)[0]
  end
  def self.futureevents
    where("startDate > ?", Date.today).order(startDate: :asc).group_by {|t| [I18n.l(t.startDate, format: :moisanneeevent), I18n.l(t.startDate, format: :monthid)]}
  
  end
  def self.nextevent
    where("startDate > ?", Date.today).order(startDate: :asc)[0]
  end
  def dateforcountdown
    ((self.startDate.to_time).localtime("-03:00")+self.time.hour+self.time.min).to_s.gsub(' -', '-').gsub(' +', '+')
  end
  def dateid
    I18n.l(self.startDate, format: :monthid)
  end
  def self.embed_remote_image(url, content_type)
    asset = open(Rails.root.to_s+"/app/assets/images/"+url, "r:UTF-8") { |f| f.read }
    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  def mypic
    Event.embed_remote_image(myimage, "image/png")
  end
  
  def self.qrcode
    Event.embed_remote_image("qrcode.png", "image/png")
  end
  def self.codeabarre
    Event.embed_remote_image("codebarre.png","image/png")
  end
  def self.weezevent
    Event.embed_remote_image("weezevent-logo001.png", "image/png")
  end
  def image
    i=read_attribute(:image)
    if i.include?('http') || i.include?(' assets')
      i
    else
      '/assets/'+i
      
    end
  end
  def myimage
    read_attribute(:image)
  end
  def self.eventstocome?
    where("startDate > ?", Date.today).length > 0
  end
  def expired?
    t=Date.today
    j=time.to_time.change(year: t.year, month: t.month, day: t.day)
    endDate.past? ||(endDate.today? && j.past?)
  end
  def notexpired?
    !expired?
  end

end
