import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["place"];

  connect() {
    this.initializeMap();
  }

  initializeMap() {
    // If leaflet has already done its mangling of <div id="map" ...>
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

    // Only add a user marker to the map if location services were successfully accessed
    if (window.userCoords) {
      L.marker(window.userCoords)
        .addTo(map)
        .bindPopup('You are here!');
    }

    // Center the map on Ventura Main Street
    map.setView([34.2816827, -119.2950365], 15);

    for (var i = 0; i < this.placeTargets.length; i++) {
      const placeIndex = i + 1;
      const place = JSON.parse(this.placeTargets[i].dataset.placeDataValue);
      this.addMarkerToMap(place, placeIndex);
    }
  }

  addMarkerToMap(place, idx) {
    const icon = L.divIcon({
      className: "custom-numbered-icon",
      html: `<div class="marker-icon">${idx}</div>`,
      iconSize: [20, 20],
      iconAnchor: [15, 20],
      popupAnchor: [0, -35],
    });
    L.marker(
      [place.coordinates.latitude, place.coordinates.longitude],
      { icon: icon },
    ).addTo(map).bindPopup(place.name);
  }
}
