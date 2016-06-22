class ReservationsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def availability_check

    available_times = Reservation.check_availability(params[:restaurant_id], params[:party_count], params[:date_selected])
    puts available_times
    render :json => {:availability => available_times}
  end

end
