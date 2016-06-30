var checkAvailability = function() {

  $(document).on('click', '#availability-button', function(e) {
    e.preventDefault();

    $(".available_times_table").empty()

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
        console.log(data.status)
        if (data.status == true){
          $(".available_times_table").removeClass('hidden');
          $(".available_times_header").removeClass('hidden');

          for (var times_index = 0; times_index < data.availability.length; times_index++){
            $(".available_times_table").append("<tr class='info'><td>" +
              "<a href='#' class='available_time_link'>" +
              data.availability[times_index] +
              "</a>" +
              "</td></tr>"
            );
          }
        } else{
          $(".available_times_table").empty()
          $(".available_times_header").addClass('hidden');
          toastr.error("Invalid date (ex: 02/04/2017)")
        }
      }
    });
  });

  $(document).on('click', '.available_time_link', function(e) {

    var current_route = window.location.pathname
    var current_route_end = current_route.substring(current_route.lastIndexOf('/') + 1);
    var new_route = current_route.replace(current_route_end, "");
    // console.log(new_route)

    var party_number = $('#party-number-select').val();
    var time = $(this).html();
    var date = $('#date-availability-input').val();
    // debugger


    $.ajax({
      url: new_route,
      type: "POST",
      dataType: "json",
      data: { party_number: party_number, time: time, date: date },
      success: function(data) {
        // debugger
        if (data.reservation == 'true') {
          window.location.assign('/');
        } else {
          $(".available_times_table").empty()
          $(".available_times_header").addClass('hidden');
          toastr.error("Invalid date (ex: 02/04/2017)")
        }
      }
    });
  });

  $(document).on('change', '#party-number-select', function(e) {
    $(".available_times_table").empty()
    $(".available_times_header").addClass('hidden');
  });

}