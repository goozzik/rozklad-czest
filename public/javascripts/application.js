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
  if ($('#within_container').css('display') == 'block') {
    $('#within_container').hide('fast')
  }
  $('#station_from_container').show('fast');
}

function toggleFromLocation() {
  if ($('#station_from_container').css('display') == 'block') {
    $('#station_from_container').hide('fast');
  }
  $('#within_container').show('fast');
}

function toggleToStation() {
  if ($('#location_to_container').css('display') == 'block') {
    $('#location_to_container').hide('fast');
  }
  $('#station_to_container').show('fast');
}

function toggleToLocation() {
  if ($('#station_to_container').css('display') == 'block') {
    $('#station_to_container').hide('fast');
  }
  $('#location_to_container').show('fast');
}
