class ApplicationController < ActionController::Base
  def render_not_found
    bypass_sign_in(current_user)
    render :template => "erreur/erreur404.html.erb",  :status => 404, layout: false
  end

end
