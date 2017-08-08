class WelcomeController < ApplicationController
  def index
    if session[:search_tag].present? && session[:search_tag] != "0"
      @photos = flickr.photos.search(tags: session[:search_tag], per_page: 480).
                to_a.in_groups_of(6).paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html
        format.js
      end
    else 
      @photos = [].paginate(page: params[:page], per_page: 10)
    end
  end

  def search
    session[:search_tag] = params[:search_tag]
    redirect_to root_path
  end
end
