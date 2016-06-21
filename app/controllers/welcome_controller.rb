class WelcomeController < ApplicationController

  def index
  end

  def search
    @restaurants = Restaurant.where('city LIKE :term', term: params[:city])
    if request.xhr?
      render :json => {:data => @restaurants}
    end
  end

end
