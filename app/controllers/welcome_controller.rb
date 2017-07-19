class WelcomeController < ApplicationController
  def index
    if session[:search_tag].present?
      @photos = flickr.photos.search(tags: session[:search_tag], per_page: 500).
                to_a.in_groups_of(2).paginate(page: params[:page], per_page: 10)
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
