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
    puts "reservations_with_sufficient_cap: " + reserved_tables_with_sufficient_cap.length.to_s
    # this has to get changed to tables not reservations

    tables_array = []
    reserved_tables_with_sufficient_cap.each do |reservation|
      table = Table.find(reservation.table_id)
      puts table
      tables_array << table

    end

    # find tables that hold the capacity requested
    tables_with_sufficient_cap = restaurant.tables.where("capacity >= ?", party_number.to_i)
    puts "tables_with_sufficient_cap: " + tables_with_sufficient_cap.length.to_s

    # open_tables
    open_tables = tables_with_sufficient_cap - tables_array
    open_tables = Table.where(id: open_tables.map(&:id))
    puts "open_tables: " + open_tables.length.to_s



    min_capacity_of_open_tables = open_tables.minimum(:capacity)

    table = open_tables.find_by(capacity: min_capacity_of_open_tables)

    # On load we want to check if a user is logged in, if not we want to log them in as a guest.
    # if current_user
      restaurant.reservations.create!(
          table: table,
          user: user,
          start_date: start_date,
          start_time: start_time,
          end_time: end_time,
          party_number: party_number
      )
    # end

    render :json => {:reservation => "success"}
  end

end
