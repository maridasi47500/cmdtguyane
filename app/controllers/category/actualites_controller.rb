class Category::ActualitesController < ApplicationController
  layout false, only: [:showembed]
  protect_from_forgery except: [:showembed]
  def guidedelarentree
    
  end
  def show
    @article=Article.findbytitle(params[:title])
    @article=@article.locallinksaison if params[:title] == "phototheque"
        session[:nbvid] = 1 if params[:title] == "videotheque"
  end
  def showembed
    @article=Article.findbytitle(params[:title])
        session[:nbvid] = 1 if params[:title] == "videotheque"
        
  end

end
