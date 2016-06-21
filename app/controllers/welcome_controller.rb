class WelcomeController < ApplicationController

  def index
  end

  def search
    # puts '----------entered schools/search route----------'
    # puts params[:input]

    @schools = Program.search(params[:input])
    if request.xhr?
      render :json => {:data => @schools}
    end
  end

end
