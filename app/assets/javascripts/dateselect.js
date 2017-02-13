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
  $('#Couch_Listing_Check_In').datepicker({
    beforeShowDay: enableAllTheseDays,
    numberOfMonths: 3,
    showButtonPanel: true
  });
  $('#Couch_Listing_Check_Out').datepicker({
    beforeShowDay: enableAllTheseDays,
    numberOfMonths: 3,
    showButtonPanel: true
  });
});