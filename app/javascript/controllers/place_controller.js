import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { data: Object, index: Number, distance: Number };
  static targets = ["distance"];

  connect() {
    let distance;
    if (window.userCoords) {
      const userLocation = L.latLng(window.userCoords[0], window.userCoords[1]);
      const placeLocation = L.latLng(this.dataValue.place.coordinates.latitude, this.dataValue.place.coordinates.longitude);
      this.distanceTarget.textContent = `${window.metersToMiles(userLocation.distanceTo(placeLocation)).toFixed(2)}mi`;
    } else {
      // Just make it an empty string so it doesn't render
      this.distanceTarget.textContent = "";
    }
  }
}
