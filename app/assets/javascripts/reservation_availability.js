var checkAvailability = function() {

  // Validates that the input string is a valid date formatted as "mm/dd/yyyy"
  // function isValidDate(dateString)
  // {
  //     // First check for the pattern
  //     if(!/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(dateString)){
  //       return false;
  //     }

  //     var current_date = Date();
  //     var input_date = new Date(dateString);

  //     if(current_date > new Date(input_date.setDate(input_date.getDate() + 1)){
  //       return false;
  //     }

  //     // Parse the date parts to integers
  //     var parts = dateString.split("/");
  //     var day = parseInt(parts[1], 10);
  //     var month = parseInt(parts[0], 10);
  //     var year = parseInt(parts[2], 10);

  //     // Check the ranges of month and year
  //     if(year < current_date.getFullYear() || year > 3000 || month == 0 || month > 12)
  //         return false;

  //     var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

  //     // Adjust for leap years
  //     if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
  //         monthLength[1] = 29;

  //     // Check the range of the day
  //     return day > 0 && day <= monthLength[month - 1];
  // };

  $(document).on('click', '#availability-button', function(e) {

    $('.availability_times_table').addClass('hidden')
    $(".availability_times_table").empty()

    // creating route to controller to check for availability
    var current_route = window.location.pathname
    var current_route_end = current_route.substring(current_route.lastIndexOf('/') + 1);
    var new_route = current_route.replace(current_route_end, "availability_check");
    // debugger

    var date_selected = $('#date-availability-input').val();
    var party_count = $('#party-number-select').val();

    //if statement needed on js side or on ruby side to make sure inputs are valid.

    $.ajax({
      url: new_route,
      type: "GET",
      dataType: "json",
      data: { date_selected: date_selected, party_count: party_count },
      success: function(data) {
        $(".available_times_table").removeClass('hidden');

        for (var times_index = 0; times_index < data.availability.length; times_index++){
          $(".available_times_table").append("<tr class='info'><td><a href='#'>" +
            data.availability[times_index] +
            "</a></td></tr>"
          );
        }
        // debugger

      }
    });

  });

}