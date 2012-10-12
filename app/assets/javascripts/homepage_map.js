var map;
var map_info = $.parseJSON($('#map_info_json').html());
var field_locations = []
var markers = [];
var iterator = 0;

$.each(map_info, function(key,value){
  field_locations.push(new google.maps.LatLng(value.lat, value.long));
});

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
    map: map,
    draggable: true
  });

  drop();

}

function drop() {
  for (var i = 0; i < field_locations.length; i++) {
    setTimeout(function() {
      addMarker();
    }, i * 350);
  }
}

function addMarker() {
  markers.push(new google.maps.Marker({
    position: field_locations[iterator],
    map: map,
    draggable: false,
    animation: google.maps.Animation.DROP,
    title: map_info[iterator].name
  }));
  iterator++;
}

$(document).ready(function() {
  if( $('#map_canvas').length  ) {
    gmaps_init();
  };
});
