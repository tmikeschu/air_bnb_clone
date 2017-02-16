$(document).on('ready page:load', function() {

  function enableAllTheseDays(date) {
    var sdate = $.datepicker.formatDate( 'yy-mm-dd', date)
    if($.inArray(sdate, gon.available_nights) != -1) {
        return [true];
    }
    return [false];  
  }
  
  $('#Check_In').datepicker({
    defaultDate: '2/1/2017'
  });
  $('#Check_Out').datepicker({
    defaultDate: '2/1/2017'
  });
  $('#First_Night').datepicker({
    defaultDate: '2/1/2017'
  });
  $('#Last_Night').datepicker({
    defaultDate: '2/1/2017'
  });
  $('#Couch_Listing_Check_In').datepicker({
    beforeShowDay: enableAllTheseDays,
    defaultDate: '2/1/2017',
    numberOfMonths: 3,
    showButtonPanel: true
  });
  $('#Couch_Listing_Check_Out').datepicker({
    beforeShowDay: enableAllTheseDays,
    defaultDate: '2/1/2017',
    numberOfMonths: 3,
    showButtonPanel: true
  });
});

