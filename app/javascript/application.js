// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

function initializeMap() {
  // if leaflet has already done its mangling of <div id="map" ...>
  if (window?.map?.childNodes?.length > 0) {
    return;
  }

  var map = L.map('map', { zoomAnimation: false });

  // Add tile layer (can be changed to other map providers)
  L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {}).addTo(map);

  // Try to geolocate the user and drop a pin
  if (window.isLocalDevelopment) {
    L.marker([34.2816827, -119.2950365]).addTo(map).bindPopup('You are here!');
  } else {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;

          // Add a marker (pin) for the user's location
          L.marker([latitude, longitude])
            .addTo(map)
            .bindPopup('You are here!');
        },
        (error) => {
          console.error('Error getting location:', error);
        }
      );
    } else {
      // TODO: set some var that yells at the user about permissions
      alert('Geolocation is not supported by your browser. You may need to update you location preferences.');
    }
  }


  map.setView([34.2816827, -119.2950365], 15);
}

document.addEventListener("DOMContentLoaded", initializeMap);
document.addEventListener("turbo:load", initializeMap);
