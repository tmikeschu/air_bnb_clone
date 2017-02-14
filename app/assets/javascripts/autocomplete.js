$(document).on('ready page:load', function() {

  $('#Available_Cities').autocomplete({
    source: gon.availableCities
  });
});
