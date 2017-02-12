var array = ["2017-02-20","2017-02-21","2017-02-22" ]

$(document).on('ready page:load', function() {
  $('#Check_In').datepicker();
  $('#Check_Out').datepicker();
  $('#Couch_Listing').datepicker({
    beforeShowDay: function(date){
      var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
      return [ array.indexOf(string) == -1 ]
    },

    numberOfMonths: 3,
    showButtonPanel: true
  });
});