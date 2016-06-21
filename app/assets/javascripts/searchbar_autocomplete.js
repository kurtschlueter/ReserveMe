var autoComplete = function() {
  var delay_in_ms = 500;
  var delay = (function(){
    var timer = 0;
    return function(callback, ms){
      clearTimeout (timer);
      timer = setTimeout(callback, ms);
    };
  })();

  $(document).delegate( ".city_search", "keyup", function(e) {
    console.log('entered keyup')
    e.preventDefault();

    var key_hit = e.keyCode;
    if (key_hit == 8) {
      delay(function(){
        var input = $(".city_search").val()
        $(".city_table").empty()

        //If input is empty, hide table.
        if (input == "") {
          $('.city_table').addClass('hidden')
        } else {
          $('.city_table').removeClass('hidden')
          if ("chicago".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#chicago' id='chi_dropdown' class='city_dropdown'>" + "Chicago" + "</a></td></tr>");
          }
          if ("new york".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#new_york' id ='nyc_dropdown' class='city_dropdown'>" + "New York" + "</a></td></tr>");
          }
          if ("san francisco".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#san_francisco' id = 'sf_dropdown' class='city_dropdown'>" + "San Francisco" + "</a></td></tr>");
          }
        }
      }, 0);
    } else {
      delay(function(){
        var input = $(".city_search").val()
        $(".city_table").empty()

        //If input is empty, hide table.
        if (input == "") {
          $('.city_table').addClass('hidden')
        } else {
          $('.city_table').removeClass('hidden')
          if ("chicago".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#chicago' id='chi_dropdown' class='city_dropdown'>" + "Chicago" + "</a></td></tr>");
          }
          if ("new york".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#new_york' id ='nyc_dropdown' class='city_dropdown'>" + "New York" + "</a></td></tr>");
          }
          if ("san francisco".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#san_francisco' id = 'sf_dropdown' class='city_dropdown'>" + "San Francisco" + "</a></td></tr>");
          }
        }
      }, 500);
    }
  });


  $(document).on('click', '.city_dropdown', function(e) {
    $(".restaurant-grid-container").empty()
    $(".city_table").empty()
    $(".city_search").val($(this).html())

    var city = $(this).html()

    $.ajax({
      url: "/welcome/search", // Route to the Script Controller method
      type: "GET",
      dataType: "json",
      data: { city: city },
      success: function(data) {
        // debugger
        $(".restaurant-grid-container").removeClass('hidden')
        for (i = 0; i < data.data.length; i++) {
          $(".restaurant-grid-container").append(
            "<div class='col-md-4 text-center'>" +
            "<div class='col-md-12 well'>" +
            "<h3><strong>" + data.data[i].name + "</strong></h3>" +
            "<img alt='restaurant image' src=" + data.data[i].image_url + ">" +
            "<h4>" + data.data[i].address + "</h4>" +
            "<h4>" + data.data[i].city + "</h4>" +
            "<h4>" + data.data[i].phone_number + "</h4>" +
            "<a href='#'><div class='view-button'><h3 class='view-header'>Make Reservation</h3></div></a>" +
            "</div>" +
            "</div>"
          );
        }
      }
    });

  });
};