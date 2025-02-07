// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
  var map = L.map('map').
    setView([34.2816827, -119.2950365], 13).
    setZoom(16);

  // Add tile layer (can be changed to other map providers)
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  // Example: Adding a marker
  L.marker([34.280693, -119.2947692]).addTo(map)
    .bindPopup('Content!')
    .openPopup();
});
