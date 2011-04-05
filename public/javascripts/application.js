function getLocation() {
  $('#loading').show();
  navigator.geolocation.getCurrentPosition(
    function(position){
      var lat = position.coords.latitude;
      var lng = position.coords.longitude;
      $.ajax({
        type: 'POST',
        url: '/pages/get_location',
        data: 'lat=' + lat + '&lng=' + lng,
        success: $('#loading').hide()
      });
    }
  )
}
