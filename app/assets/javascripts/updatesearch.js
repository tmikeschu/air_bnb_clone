$(document).on('ready page:load', function() {

  $(".update_search").on("click", function() {
    var destination = $(".destination").val();
    var check_in    = $(".check_in").val();
    var check_out   = $(".check_out").val();

    $.ajax({
      type: 'GET',
      url: '/update',
      dataType: 'json',
      data: {"Destination" : destination, "Check In" : check_in, "Check Out" : check_out}
    });
  });

});
