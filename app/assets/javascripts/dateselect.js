$(document).on('ready page:load', function() {

  function enableAllTheseDays(date) {
    var sdate = $.datepicker.formatDate( 'yy-mm-dd', date)
    if($.inArray(sdate, gon.available_nights) != -1) {
        return [true];
    }
    return [false];  
  }
  
  $('#Check_In').datepicker();
  $('#Check_Out').datepicker();
  $('#First_Night').datepicker();
  $('#Last_Night').datepicker();
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

