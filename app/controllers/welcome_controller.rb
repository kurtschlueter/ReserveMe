class WelcomeController < ApplicationController

  def index
    if current_user
    else
      user = User.find_by_email('guest@guest.com')
      session[:user_id] = user.id
    end
  end

  def search
    @restaurants = Restaurant.where(city: params[:city])
    if request.xhr?
      render :json => {:data => @restaurants}
    end
  end

end
