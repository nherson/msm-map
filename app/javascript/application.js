// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
  var map = L.map('map').
    setView([34.2816827, -119.2950365], 13).
    setZoom(16);

  // Add tile layer (can be changed to other map providers)
  L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {}).addTo(map);

  // Try to geolocate the user and drop a pin
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const { latitude, longitude } = position.coords;
  
        // Set the map view to the user's location
        // map.setView([latitude, longitude], 13);
  
        // Add a marker (pin) for the user's location
        L.marker([latitude, longitude])
          .addTo(map)
          .bindPopup('You are here!')
      },
      (error) => {
        console.error('Error getting location:', error);
        alert(error.message);
      }
    );
  } else {
    alert('Geolocation is not supported by your browser.');
  }

  map.setView([34.2816827, -119.2950365], 13)
});
