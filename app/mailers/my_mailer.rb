require 'nokogiri'
require 'open-uri'
class MyMailer < ActionMailer::Base
  layout 'mailer'
  def welcome_email
    @user = params[:user]
    @ticket = params[:ticket]
    @buyer = params[:buyer]
    @event=params[:event]
    @range=@event.myrange(@ticket.id).to_a
    @sender="Weezevent <cleo.ordioni@gmail.com>"
    @recipient='cleo.ordioni@gmail.com'
    @url  = 'http://localhost:3000'
    @urlbillet=showbillet_url(@event.id,ticket_id: @ticket.id, format: [:pdf], host: "localhost:3000")
    @nocommande=@event.commande(@ticket.id).to_s
    uri = URI.parse("http://www.ruby-lang.org/en/") 
    name=I18n.l(Date.today, format: :pdffile)+'_COMMANDE_'+@nocommande
    attachments[name+'.pdf'] = WickedPdf.new.pdf_from_string(render_to_string(pdf: name, 
                      page_size: 'A4',
                template: "category/evenements/billetemail.pdf.erb",
                layout: "pdf2.html",
                orientation: "Portrait",
                disposition: "attachment",
                
                    encoding: 'UTF-8',
    disable_smart_shrinking:        true,

                lowquality: true,
                zoom: 1, dpi: 75)
            )
    mail(from: @sender,to: @recipient, subject: ('Votre commande pour '+@event.name))
  end

end
