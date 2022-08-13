class Category::EspacebrocanteController < ApplicationController
  protect_from_forgery except: [:deposeruneannonce,:voirannonce, :supprad,:savead]
  before_action :authenticate_user!, only: [:deblocmail]
  def index
    
  end
  def voirmail
    @ad = Ad.find_by_url(params[:title])
    @post=Article.findbythetitle("vendeur")

    render "ads/show"
  end
  def deblocmail
    @ad = Ad.find_by_url(params[:title])
    if user_signed_in? && !current_user.staff
      
      
    p "pas du staff", loginstaff_path(actions: "administrator")
    redirect_to loginstaff_path(actions: "administrator")
    else
      begin
    @ad.update(verified: true)
      rescue
      end
    redirect_to modifierannonce_path(advert_id: @ad.id), notice: "Merci d'avoir validé l'annonce."
    end
  end
  def modifierannonce
    @ad=Ad.find(params[:advert_id])
  end
  def supprad
    if params[:ajax] == "1"
      
    @ad=Ad.find(params[:id]) rescue nil
    if @ad && @ad.destroy
      render json: {"result"=>1,"message"=>"Annonce <strong>#{@ad.title}<\/strong> effac\u00e9e."}
    else
      render json: {"result"=>0,"message"=>"L'annonce n'a pas été trouvée."}
    end
    end
  end
  def editad
        @ad = Ad.find(params[:advert_id])
  end
  def moncompte
    @article=Article.findbythetitle("mon compte").locallinks
    @ads = user_signed_in? ? Ad.mylist(current_user.email) : nil

  end
  def voirannonce
    @ad = Ad.find_by_url(params[:title])
    @post=Article.findbythetitle("vendeur")

    render "ads/show"
  end
  def see
    @ad = Ad.find(params[:p]) if params[:post_type] == "advert"
    @post=Article.findbythetitle("vendeur")
    if (@post && @ad && @ad.verified)
    render "ads/show"
    else
      render_not_found
    end
  end
  def espaceacheteur
    @post=Article.findbythetitle("acheteur")
    @ads=Ad.findby(params[:query],params[:location])
  end
  def espacevendeur
    @post=Article.findbythetitle("vendeur")
  end
  def savead
        @ad = Ad.find(params[:_post_id]) rescue nil
        p @ad
      @ad.update(publish: true)
    @post=Article.findbythetitle("vendeur")

    render :annonceok

  end
  def updatead
            @ad = Ad.find(params[:advert_id])
    @post=Article.findbythetitle("vendeur")

      @ad.update(ad_params)
      render :editad
  end
  def deposeruneannonce


    if params[:_adverts_action] && params[:post_content] && @ad = Ad.find(params[:_post_id]) rescue nil
    @post=Article.findbythetitle("vendeur")

      @ad.update(ad_params)
    elsif @ad = Ad.find(params[:_post_id]) rescue nil
      
    
    @post=Article.findbythetitle("vendeur")

      render :espacevendeur
    else
    @post=Article.findbythetitle("déposer annonce")

    @ad=Ad.new(ad_params)
    @ad.save
    end
  end
  private
  def ad_params
    params.permit("adverts_person",:madesc, :adverts_email, :adverts_phone, :post_title, :post_content, :adverts_price, :adverts_location,:pics=>[],:advert_category=>[])
  end
end
