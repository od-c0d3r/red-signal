import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="geolocation"
export default class extends Controller {
  connect() {
    console.log("Geolocation controller connected")
  }

  sendLocation(event) {
    if (event.target.checked) {
      if (navigator.geolocation) {
        let lastSentAt = 0;
        const THROTTLE_MS = ((0/*<-- seconds*/)+(60* 15/*<-- minutes*/)+(60*60* 0/*<-- hours*/)) * 1000;

        navigator.geolocation.watchPosition((position) => {
          const now = Date.now();
          if (now - lastSentAt < THROTTLE_MS) return;

          lastSentAt = now;
          const latitude = position.coords.latitude
          const longitude = position.coords.longitude

          fetch("/update_location", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({ latitude: latitude, longitude: longitude })
          })
          .then(response => {
            if (response.ok) {
              console.log("Location updated successfully")
            } else {
              console.error("Error updating location")
            }
          })
        })
      } else {
        console.error("Geolocation is not supported by this browser.")
      }
    }
  }
}
