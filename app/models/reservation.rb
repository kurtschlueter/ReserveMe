class Reservation < ActiveRecord::Base
  belongs_to :table
  belongs_to :user
  belongs_to :restaurant

  def self.valid_date(date_string)

    status = Date.strptime(date_string, '%m/%d/%Y') rescue false

    length_date_string = date_string.length
    length_nums_slashes = date_string.scan(/[0-9\/]/).length

    if length_nums_slashes != length_date_string
      status = false
    end

    if status != false
      puts 'true'
      return true
    else
      puts 'false'
      return false
    end

  end

  # This check the availabilty for a specific day. This will return a hash that has each minute of the day that the resuarant is open as the keys, and the number of tables available with the requested party number for each minute
  def self.check_availability_for_day(restaurant_id, party_number, date)

    restaurant = Restaurant.find(restaurant_id.to_i)

    # find all reservations for that resaurant on that day
    all_reservations = restaurant.reservations.where(start_date: Date.strptime(date, '%m/%d/%Y'))

    # find tables that hold the capacity requested
    tables_with_sufficient_cap = restaurant.tables.where("capacity >= ?", party_number.to_i)

    #find reservations that hold the requested capacity
    reservations_with_sufficient_cap = all_reservations.where("party_number >= ?", party_number.to_i)

    # start off with a hash of minutes from 6 to 10 that all start off with full capacity (tables_with_sufficient_cap.length)
    minutes_in_day = 1440
    six_pm_minute = 1080
    eleven_pm_minute = 1380
    total_open_minutes = eleven_pm_minute - six_pm_minute

    minutes_tables_open_hash = Hash.new
    for minute in six_pm_minute..eleven_pm_minute
      minutes_tables_open_hash[minute] = tables_with_sufficient_cap.length
    end

    # for each minute
    minutes_tables_open_hash.each do |key,value|

      # for each reservation table with sufficient cap
      reservations_with_sufficient_cap.each do |reservation|

        # does this land on the looped minute
        reservation_minute_start = (reservation.start_time.hour * 60 + reservation.start_time.min)
        reservation_minute_end = (reservation.end_time.hour * 60 + reservation.end_time.min)

        # if it does, then that minute loses a table
        if key > reservation_minute_start && key < reservation_minute_end
          minutes_tables_open_hash[key] = minutes_tables_open_hash[key] - 1
        end
      end
    end
    # we need to convert it time sections
    return available_times_conversion(minutes_tables_open_hash)
  end

  # This formats the available times in a string form "18:00" for example from the mintues hash produced above in the check avaiability for day method
  def self.available_times_conversion(minutes_hash)
    section = 0
    available_time_sections_array = []

    # loop through minutes hash
    minutes_hash.each do |key,value|

      # if minute is booked, section starts over
      if value == 0
        section = 0
      end

      # if minute is not booked, section continues
      if value != 0
        section = section + 1
      end

      # Reservations are an hour long
      if section == 60
        # reset
        section = 0
        end_section_hour = (key / 60).to_s
        # puts "end hour: " + end_section_hour
        end_section_minute = (key - end_section_hour.to_i * 60).to_s
        # puts "end minute: " + end_section_minute


        start_section_hour = (((key + 1 - 60) / 60)).to_s
        # puts "start hour: " + start_section_hour
        start_section_minute = ((end_section_minute.to_i + 1) - 60).abs.to_s
        # puts "start minute: " + start_section_minute

        if start_section_minute.length == 1
          available_time_sections_array << start_section_hour + ":0" + start_section_minute
        else
          available_time_sections_array << start_section_hour + ":" + start_section_minute
        end

      end
    end
    return available_time_sections_array
  end

end
