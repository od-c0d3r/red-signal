import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searching-nearby"
export default class extends Controller {
  connect() {
    console.log("Searching nearby controller connected")

    this.element.addEventListener("click", (event) => {
      event.preventDefault()

      const queryString = window.location.search;
      const urlParams = new URLSearchParams(queryString);
      const lat = urlParams.get('lat');
      const lng = urlParams.get('lng');

      fetch('/admin/searching_nearby.turbo_stream', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          distance: this.element.closest("form")[5].value,
          lat,
          lng
        })
      })
    })
  }
}
