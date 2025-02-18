// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

const fallbackCoords = [34.2816827, -119.2950365];

let map;

function initializeMap() {
  // if leaflet has already done its mangling of <div id="map" ...>
  if (window?.map?.childNodes?.length > 0) {
    return;
  }

  map = L.map('map', {
    zoomAnimation: false,
    attributionControl: false,
    zoomControl: false,
  });

  // Add tile layer (can be changed to other map providers)
  L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {}).addTo(map);

  // Try to geolocate the user and drop a pin
  let userCoords;
  if (window.isLocalDevelopment) {
    userCoords = fallbackCoords;
  } else {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          userCoords = [latitude, longitude];
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

  // TODO: create a better fallback when location cannot be determined
  if (!userCoords) {
    userCoords = fallbackCoords;
  }

  L.marker(userCoords)
    .addTo(map)
    .bindPopup('You are here!');

  map.setView([34.2816827, -119.2950365], 15);
  // addIconToMap();
}

// function addIconToMap() {
//   // DEBUG test setting a route
//   // 34.28104289999999, -119.2897968 --> VenTiki
//   const ventiki = [34.28104289999999, -119.2897968];
//   console.log(window.map);

//   const icon = L.divIcon({
//     className: "custom-numbered-icon",
//     html: `<div class="marker-icon">1</div>`,
//     iconSize: [30, 30], // Size of the icon
//     iconAnchor: [15, 20], // Point where the icon is anchored
//     popupAnchor: [0, -35], // Where the popup appears relative to the icon
//   });
//   L.marker(ventiki, { icon: icon }).addTo(map).bindPopup('Ventiki');
// }

document.addEventListener("DOMContentLoaded", initializeMap);
document.addEventListener("turbo:load", initializeMap);
