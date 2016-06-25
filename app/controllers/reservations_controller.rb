class ReservationsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def availability_check

    available_times = Reservation.check_availability(params[:restaurant_id], params[:party_count], params[:date_selected])
    puts available_times
    render :json => {:availability => available_times}
  end

  def create
    puts '----------reso create route -------------'
    puts params

    restaurant = Restaurant.find(params[:restaurant_id])
    user = User.first
    start_time = DateTime.strptime(params[:date] + " " + params[:time], '%m/%d/%Y %H:%M')
    end_time = start_time + (1 / 24.0)
    start_date = Date.strptime(params[:date], '%m/%d/%Y')
    party_number = params[:party_number].to_i

    # find all reservations for that resaurant on that day
    all_reservations = restaurant.reservations.where(start_date: start_date)

    #find tables reserved that hold the requested capacity
    reserved_tables_with_sufficient_cap = all_reservations.where("party_number >= ?", party_number)
    # this has to get changed to tables not reservations

    # find tables that hold the capacity requested
    tables_with_sufficient_cap = restaurant.tables.where("capacity >= ?", party_number.to_i)

    # open_tables
    open_tables = tables_with_sufficient_cap - reserved_tables_with_sufficient_cap

    puts "----------open tabels ---------------"
    puts open_tables.length

    min_capacity_of_open_tables = open_tables.minimum(:capacity)

    table = open_tables.find_by(capacity: min_capacity_of_open_tables)

    # On load we want to check if a user is logged in, if not we want to log them in as a guest.
    if current_user
      restaurant.reservations.create!(
          table: table,
          user: user,
          start_date: start_date,
          start_time: start_time,
          end_time: end_time,
          party_number: capacity
      )
    end

    redirect '/'
  end

end
