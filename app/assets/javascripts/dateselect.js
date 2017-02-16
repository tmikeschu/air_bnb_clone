$(document).on('ready page:load', function() {

  function enableAllTheseDays(date) {
    var sdate = $.datepicker.formatDate( 'yy-mm-dd', date)
    if($.inArray(sdate, gon.available_nights) != -1) {
        return [true];
    }
    return [false];  
  }
  
  $('#Check_In').datepicker({
    minDate: 0
  });
  $('#Check_Out').datepicker({
    minDate: 0
  });
  $('#First_Night').datepicker({
    minDate: 0
  });
  $('#Last_Night').datepicker({
    minDate: 0
  });
  $('#Couch_Listing_Check_In').datepicker({
    beforeShowDay: enableAllTheseDays,
    minDate: 0,
    numberOfMonths: 3,
    showButtonPanel: true
  });
  $('#Couch_Listing_Check_Out').datepicker({
    beforeShowDay: enableAllTheseDays,
    minDate: 0,
    numberOfMonths: 3,
    showButtonPanel: true
  });
});

