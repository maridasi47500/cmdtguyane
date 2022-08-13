
class WelcomeController < ApplicationController
  protect_from_forgery except: [:contactus]
  def index
    @news=Article.latestnews
    @nextevent=Event.nextevent
    if params[:s]
    @articles=Article.search(params[:s]).allmyarticles(params[:id],params[:s]).to_a
      @myarticles=Article.search(params[:s]).myarticles(params[:id],params[:s]).to_a
      @mytitle="Recherche : #{params[:s]}"
      render "presentation/search"
    else 
      render :index
    end

  end
  def contact
    
  end
  def contactus
    @message=Message.newone(msg_params.values)
    if !@message.valid?
    	render json: {"into"=>"#wpcf7-f1276-p147-o1","status"=>"validation_failed","message"=>"Un ou plusieurs champs contiennent une erreur. Veuillez v\u00e9rifier et essayer \u00e0 nouveau.","invalidFields"=>@message.errors.messages.to_a.map {|field,msg|{"into"=>"span.wpcf7-form-control-wrap.#{field.to_s.gsub('_','-')}","message"=>msg,"idref"=>nil}}}
    else
      render json: {"into"=>"#wpcf7-f1276-p147-o1","status"=>"mail_sent","message"=>"Merci pour votre message. Il a \u00e9t\u00e9 envoy\u00e9."}
    end
  end
  private
  def msg_params
    params.permit("your-email","your-subject","your-name","your-message")
  end
end


#hash originaus erreur
    	#render json: {"into"=>"#wpcf7-f1276-p147-o1","status"=>"validation_failed","message"=>"Un ou plusieurs champs contiennent une erreur. Veuillez v\u00e9rifier et essayer \u00e0 nouveau.","invalidFields":[{"into"=>"span.wpcf7-form-control-wrap.your-email","message"=>"L\u2019adresse e-mail n\u2019est pas valide.","idref":nil}]}
    #else SUCCESS
    #  render json: {"into"=>"#wpcf7-f1276-p147-o1","status"=>"mail_sent","message"=>"Merci pour votre message. Il a \u00e9t\u00e9 envoy\u00e9."}
