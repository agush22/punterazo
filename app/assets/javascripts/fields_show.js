var map;
var map_info = $.parseJSON($('#map_info_json').html());

function gmaps_init(){
  // Mexico City
  var latlng = new google.maps.LatLng(19.4326077,-99.13320799999997);
  var options = {
    zoom: 7,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  // Create new google maps, geocoder, and marker objects.
  map = new google.maps.Map(document.getElementById("map_canvas"), options);
  marker = new google.maps.Marker({
    position: new google.maps.LatLng(map_info.lat, map_info.long),
    map: map,
    draggable: false,
    animation: google.maps.Animation.DROP,
    title: map_info.name
  });
}


$(document).ready(function() {
  if( $('#map_canvas').length  ) {
    gmaps_init();
  };
});

