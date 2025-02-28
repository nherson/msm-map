// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

const FALLBACK_COORDS = [34.2816827, -119.2950365];

window.metersToMiles = function (meters) {
  return meters * 0.000621371;
};

// Best effort geolocation for the user, with somewhat graceful fallback
if (window.isLocalDevelopment) {
  window.userCoords = FALLBACK_COORDS;
} else {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const { latitude, longitude } = position.coords;
        window.userCoords = [latitude, longitude];
      },
      (error) => {
        console.error('Error getting location:', error);
      }
    );
  } else {
    // TODO: somehow tell the person that they should enable location services for the site
    console.log('Geolocation is not supported by your browser. You may need to update you location preferences.');
  }
}
