class Category::EvenementsController < ApplicationController
  protect_from_forgery except: [:ajax]
  layout false, only: [:ajax]
  def voirunevenement
    @event=Event.findbytitle(params[:name])
  end
  def seeevent
    @ticket=Ticket.find(params[:ticket_id])
    @event=Event.find(params[:id])
    @range=@event.myrange(@ticket.id).to_a
        respond_to do |format|
            format.html do
              render :billet
            end
            format.pdf do
                render pdf: "votre billet",
                page_size: 'A4',
                template: "category/evenements/billet.html.erb",
                layout: "pdf.html",
                orientation: "Portrait",
                lowquality: true,
                zoom: 1,
                dpi: 75
            end
        end

  end
  def ajax
    @calendar=Calendar.new(params[:mec_year],params[:mec_month]).firstmonth
    render locals: {mois: @calendar}, formats: [:json]
  end
end
