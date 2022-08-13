class PresentationController < ApplicationController
    include MyhelperHelper
    before_action :paginationpages, only: [:search]
  after_action :addvues, only: [:edgarnibul,:lecmdtg,:localisation,:conseildadministration,:historique]
  def font
    begin
    render file: "public/fonts/#{params[:namefont]}"
  rescue 
    begin
    `cd /home/mary/cmdtg/public/fonts && wget "https://cmdt-guyane.fr/wp-content/plugins/essential-grid/public/assets/font/fontello/#{params[:namefont].split('.')[1]}/#{params[:namefont]}?ver=#{params[:v]}"`
    render file: "public/fonts/#{params[:namefont]}"
  rescue 
    render inline: ""
  end
  end
    end

  def lecmdtg
    @post=Post.findbythetitle("le cmdtg")

  end
  def evenements
    @post=Post.findbyexacturl("/evenements")
    @calendar=Calendar.new.mois
  end

  def historique
    @post=Post.findbythetitle("historique")
  end
  def organigramme
    @post=Post.findbythetitle("organigramme")
  end
  def conseildadministration
    @post=Post.findbythetitle("conseil d administration")
  end
  def postuler
    @post=Post.findbythetitle("postuler")
  end
  def logo
    @post=Post.findbythetitle("logo")
  end
  def localisation
    @post=Post.findbythetitle("localisation")
  end
  def edgarnibul
    @post=Post.findbythetitle("nibul")
  end
  def actualites
        @mypages=Actualite.mynewspages("", params[:id])
        @articles=Actualite.allmynewsarticles(params[:s],params[:id])
      @myarticles=Actualite.mynewsarticles(params[:s],params[:id])

  end
  def theatre
    
  end
  private
  def paginationpages
        @articles=Actualite.allmyarticles(params[:s],params[:id])
      @myarticles=Actualite.myarticles(params[:s],params[:id])

      @mypages=Actualite.mypages(params[:s], params[:id])

  end
end
