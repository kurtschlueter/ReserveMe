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
              $(".city_table").append("<tr class='info'><td><a href='#'>" + "Chicago" + "</a></td></tr>");
            }
            if ("new york".indexOf(input.toLowerCase()) > -1 ) {
              $(".city_table").append("<tr class='info'><td><a href='#'>" + "New York" + "</a></td></tr>");
            }
            if ("san francisco".indexOf(input.toLowerCase()) > -1 ) {
              $(".city_table").append("<tr class='info'><td><a href='#'>" + "San Francisco" + "</a></td></tr>");
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
            $(".city_table").append("<tr class='info'><td><a href='#'>" + "Chicago" + "</a></td></tr>");
          }
          if ("new york".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#'>" + "New York" + "</a></td></tr>");
          }
          if ("san francisco".indexOf(input.toLowerCase()) > -1 ) {
            $(".city_table").append("<tr class='info'><td><a href='#'>" + "San Francisco" + "</a></td></tr>");
          }
        }
      }, 500);
    }
  });
};