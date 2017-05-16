if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(
    function(position) {
      var coords = position.coords;
      var lat = coords.latitude;
      var lng = coords.longitude;
      console.log(lat, lng);
      $.post('/location', {lat: lat, lng: lng});
    },
    function() {
      // handleLocationError(true, infoWindow, map.getCenter());
      console.log('geolocation error');
    }
  );
} else {
  // Browser doesn't support Geolocation
  console.log("browser doesn't support geolocation")
}
