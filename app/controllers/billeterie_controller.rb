class BilleterieController < ApplicationController
  layout false
  protect_from_forgery except: [:widget]
  def index
    @event=Event.find(params[:event_id])
      @ticket=@event.createticket

  end
  def widget
    @event=Event.find(params[:id_evenement])
    @event.update(billet_params)
      @ticket=Ticket.find(@event.myticketid)
        @buyer =@ticket.buyer || @event.mybuyer
        p @buyer
    case params[:current_step]
    when "tickets"
      p @event.valid?
      p @event.errors
      render :widget
    when "form"
      if @buyer.valid? && @buyer.errors.count == 0 && @event.errors.count == 0 && @ticket.update(buyer: @buyer)
        p @ticket
        p @ticket.buyer
              MyMailer.with(user: current_user, ticket: @ticket, buyer: @buyer,event: @event).welcome_email.deliver_now

      render :form
      else
        render :formerrors
      end
    end

  end
  private
  def billet_params
    params.permit(:country_code,:quantite,:current_url, :current_step, :widgetState, :wsid, :recapTickets, :start_date, :champs_3_0, :champs_2_0, :champs_5_0, :champs_36_0, :champs_7_0, :facturation_societe, :facturation_tva_intra, :facturation_adresse, :facturation_cp, :facturation_ville, :facturation_pays, :facturation_info, :id_evenement, :locale, :code, :color_primary,:facturation, :accepte_cgv,:seatsToken, :montantBilletInitial_0, :id_code_cpt_0, :quantite_initiale_min, :quantite_initiale, :chps_montant_0, :cpt_chps, :group_size, :aff_ht, :aff_comm, :chps_montant_final, :chps_spb_amount_total_ttc, :chps_spb_count_charged_tickets, :nbCodeUsed)
  end
end
