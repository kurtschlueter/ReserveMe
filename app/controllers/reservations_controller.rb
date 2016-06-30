class ReservationsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def availability_check
    if Reservation.valid_date(params[:date_selected]) == true
      puts 'true'
      available_times = Reservation.check_availability_for_day(params[:restaurant_id], params[:party_count], params[:date_selected])
      statuss = true
      render :json => {:availability => available_times, :status => statuss}
    else
      puts 'false'
      available_times = []
      statuss = false
      render :json => {:availability => available_times, :status => statuss}

    end

  end

  def create

    if Reservation.valid_date(params[:date]) == true

      restaurant = Restaurant.find(params[:restaurant_id])
      user = current_user
      start_time = DateTime.strptime(params[:date] + " " + params[:time], '%m/%d/%Y %H:%M')
      end_time = start_time + (1 / 24.0)
      start_date = Date.strptime(params[:date], '%m/%d/%Y')
      party_number = params[:party_number].to_i

      # find all reservations for that resaurant on that day
      all_reservations = restaurant.reservations.where(start_time: start_time)

      puts "all resos for that day and time: " + all_reservations.length.to_s


      #find tables reserved that hold the requested capacity
      reserved_tables_with_sufficient_cap = all_reservations.where("party_number >= ?", party_number)
      puts "reservations_with_sufficient_cap: " + reserved_tables_with_sufficient_cap.length.to_s
      # this has to get changed to tables not reservations

      tables_array = []
      reserved_tables_with_sufficient_cap.each do |reservation|
        puts reservation.id
        puts reservation.table_id
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

      if open_tables.length > 0
        restaurant.reservations.create!(
            table: table,
            user: user,
            start_date: start_date,
            start_time: start_time,
            end_time: end_time,
            party_number: party_number
        )
        render :json => {:reservation => "success"}
        flash[:success] = 'View reservation on user page'
      else
        render :json => {:reservation => "fail"}
        flash[:error] = 'No more available at this time and day'
      end
    else
      render :json => {:reservation => "fail"}
    end
  end

  def destroy
    # puts params
    restaurant = Restaurant.find(params[:restaurant_id])
    reservation = Reservation.find(params[:id])
    reservation.destroy
    flash[:success] = 'Reservation Cancelled'
    redirect_to current_user
  end
end
