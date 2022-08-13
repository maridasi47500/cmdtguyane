class PhotosController < ApplicationController
  def saison20202021
    @phototheque=Phototheque.findmy(params[:annee1],params[:annee2])
    @albums=@phototheque.albums
    render :saison20202021
  end
end
