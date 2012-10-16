var geocoder;
var map;
var marker;

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
  geocoder = new google.maps.Geocoder();
  marker = new google.maps.Marker({
    map: map,
    draggable: true
  });

  // Event triggered when marker is dragged and dropped
  google.maps.event.addListener(marker, 'dragend', function() {
    geocode_lookup( 'latLng', marker.getPosition() );
  });

  // Event tiggered on double click
  //google.maps.event.addListener(map, 'dblclick', function(event) {
  //  map.setZoom(map.getZoom()+1);
  //  map.setCenter(event.latLng);
  //});

  // Event triggered when map is clicked
  google.maps.event.addListener(map, 'click', function(event) {
    marker.setPosition(event.latLng)
    geocode_lookup( 'latLng', event.latLng  );
  });

}

// Move the marker to a new position, and center the map on it
function update_map( geometry ) {
  map.fitBounds( geometry.viewport )
  marker.setPosition( geometry.location )
}

// Fill in the UI elements with new position data
function update_ui( address, latLng, components ) {
  $('#field_address').autocomplete("close");
  $('#field_address').val(address);
  $('#field_lat').val(latLng.lat());
  $('#field_long').val(latLng.lng());
  console.log(components);
  $.each(components, function(componentKey,componentValue){
    $.each(componentValue.types, function(typeKey, typeValue){
      switch(typeValue){
        case "route":
          $('#field_street').val(componentValue.long_name);
          break;
        case "neighborhood":
          $('#field_neighbourhood').val(componentValue.long_name);
          break;
        case "locality":
          $('#field_city').val(componentValue.long_name);
          break;
        case "administrative_area_level_1":
          $('#field_state').val(componentValue.long_name);
          break;
        case "country":
          $('#field_country').val(componentValue.long_name);
          break;
      };
    });
  });
}

// Query the Google geocode object
//
// type: 'address' for search by address
//       'latLng'  for search by latLng (reverse lookup)
//
// value: search query
//
// update: should we update the map (center map and position marker)?
function geocode_lookup( type, value, update ) {
  // default value: update = false
  update = typeof update !== 'undefined' ? update : false;

  request = { region: 'mx' };
  request[type] = value;

  geocoder.geocode(request, function(results, status) {
    $('#gmaps-error').hide();
    $('#gmaps-error').html('');
    if (status == google.maps.GeocoderStatus.OK) {
      // Google geocoding has succeeded!
      if (results[0]) {
        // Always update the UI elements with new location data
        update_ui( results[0].formatted_address, results[0].geometry.location, results[0].address_components)
                  // Only update the map (position marker and center map) if requested
                  if( update ) { update_map( results[0].geometry ) }
      } else {
        // Geocoder status ok but no results!?
        $('#gmaps-error').show();
        $('#gmaps-error').html("Sorry, something went wrong. Try again!");
      }
    } else {
      // Google Geocoding has failed. Two common reasons:
      //   * Address not recognised (e.g. search for 'zxxzcxczxcx')
      //   * Location doesn't map to address (e.g. click in middle of Atlantic)

      if( type == 'address' ) {
        // User has typed in an address which we can't geocode to a location
        $('#gmaps-error').show();
        $('#gmaps-error').html("Sorry! We couldn't find " + value + ". Try a different search term, or click the map." );
      } else {
        // User has clicked or dragged marker to somewhere that Google can't do a
        // reverse lookup for. In this case we display a warning.
        $('#gmaps-error').show();
        $('#gmaps-error').html("Woah... that's pretty remote! You're going to have to manually enter a place name." );
        update_ui('', value, [])
      }
    };
  });
};

// Initialize the jqueryUI autocomplete element
function autocomplete_init() {
  $("#field_address").autocomplete({

    // source is the list of input options shown in the autocomplete dropdown.
    // see documentation: http://jqueryui.com/demos/autocomplete/
    source: function(request,response) {

      // the geocode method takes an address or LatLng to search for
      // and a callback function which should process the results into
      // a format accepted by jqueryUI autocomplete
      geocoder.geocode( {'address': request.term }, function(results, status) {
        response($.map(results, function(item) {
          return {
            label: item.formatted_address, // appears in dropdown box
            value: item.formatted_address, // inserted into input element when selected
            geocode: item,                  // all geocode data
            components: item.address_components // address components(street, state, country)
          }
        }));
      })
    },

    // event triggered when drop-down option selected
    select: function(event,ui){
      update_ui(  ui.item.value, ui.item.geocode.geometry.location, ui.item.components )
      update_map( ui.item.geocode.geometry )
    }
  });

  // triggered when user presses a key in the address box
  $("#field_address").bind('keydown', function(event) {
    if(event.keyCode == 13) {
      geocode_lookup( 'address', $('#field_address').val(), true );

      // ensures dropdown disappears when enter is pressed
      $('#field_address').autocomplete("disable")
    } else {
      // re-enable if previously disabled above
      $('#field_address').autocomplete("enable")
    }
  });
}; // autocomplete_init

$(document).ready(function() {
  if( $('#map_canvas').length  ) {
    gmaps_init();
    autocomplete_init();
  };
});
