function getLocation() {
  navigator.geolocation.getCurrentPosition(
    function(position){
      var lat = position.coords.latitude;
      var lng = position.coords.longitude;
      $.ajax({
        type: 'POST',
        url: '/pages/get_location',
        data: 'lat=' + lat + '&lng=' + lng,
      });
    }
  )
}

function toggleFromStation() {
  $('#within_container').hide('slow');
  $('#station_from_container').show('slow');
}

function toggleFromLocation() {
  $('#station_from_container').hide('slow');
  $('#within_container').show('slow');
}

function toggleToStation() {
  $('#location_to_container').hide('slow');
  $('#station_to_container').show('slow');
}

function toggleToLocation() {
  $('#station_to_container').hide('slow');
  $('#location_to_container').show('slow');
}
