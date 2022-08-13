class CategoryController < ApplicationController
  def vie_scolaire
  end
  def mycat
    @cat=Artcat.findbyurl(params[:title])
    p @cat
    p @cat.posts
    @allposts=@cat.allotherposts
  end
  def actualites

  end
  def presentation
    redirect_to lecmdtg_path
  end

end
