import { Controller } from "@hotwired/stimulus"
import * as L from "leaflet"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    events: Array,
    usersWithLongLat: Array,
    lat: { type: Number, default: Number(sessionStorage.getItem("mapLat")) || 31.199755},
    lng: { type: Number, default: Number(sessionStorage.getItem("mapLng")) || 29.955631},
    zoom: { type: Number, default: Number(sessionStorage.getItem("mapZoom")) || 7 }
  }

  connect() {
    console.log("Map controller connected")

    this.map = L.map(this.element).setView([this.latValue, this.lngValue], this.zoomValue)

    this.map.on("zoomend", () => {
      sessionStorage.setItem("mapZoom", this.map.getZoom());
    });

    this.map.on("moveend", () => {
        const center = this.map.getCenter();

        sessionStorage.setItem("mapLat", center.lat);
        sessionStorage.setItem("mapLng", center.lng);
        sessionStorage.setItem("mapZoom", this.map.getZoom());
    });

    this.map.on("click", (e) => {
      if (e.originalEvent.target.id === "fullscreen-button") {
        return
      }

      if (confirm('Add event at this location?')) {
        window.location.replace(`/events/new?lat=${e.latlng.lat}&lng=${e.latlng.lng}`);
      } else {
        return
      }
    })

    // Add custom fullscreen control
    const fullscreenControl = L.control({ position: "topright" })
    fullscreenControl.onAdd = (map) => {
      const div = L.DomUtil.create("div", "leaflet-bar leaflet-control")

      const link = L.DomUtil.create("a", "leaflet-control-fullscreen-button", div)
      link.id = "fullscreen-button"
      link.href = "#"
      link.title = "Toggle fullscreen"
      link.innerHTML = "⛶"
      link.style.fontSize = "18px"


      L.DomEvent.on(link, "click", (e) => {
        L.DomEvent.preventDefault(e)
        if (!document.fullscreenElement) {
          this.element.requestFullscreen().catch(err => console.error(err))
        } else {
          document.exitFullscreen()
        }
      })

      return div
    }
    fullscreenControl.addTo(this.map)

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
    }).addTo(this.map)

    const svgIcon = L.divIcon({
      className: "custom-pin",
      html: `
        <svg fill="#e74c3c" height="300%" viewBox="-69 0 117 256">
          <path filter="url(#shadow)" d="M-10.9,4.9c11.3,0,20.5,9.2,20.5,20.5S0.4,45.9-10.9,45.9s-20.5-9.2-20.5-20.5S-22.2,4.9-10.9,4.9z M14.9,51.2h-51.2
	        c-14.2,0-25.6,11.4-25.6,25.6v62.6c0,4.9,3.9,9,9,9s9-3.9,9-9V81.9c0-1.4,1.2-2.6,2.6-2.6s2.6,1.2,2.6,2.6v155.2
	        c0,7.7,5.7,14,12.8,14s12.8-6.3,12.8-14v-88.5c0-1.4,1.2-2.6,2.6-2.6c1.4,0,2.6,1.2,2.6,2.6v88.5c0,7.7,5.7,14,12.8,14
	        c7.1,0,12.8-6.3,12.8-14V81.9c0-1.4,1.2-2.6,2.6-2.6s2.6,1.2,2.6,2.6v57.6c0,4.9,3.9,9,9,9s9-3.9,9-9V76.8
	        C40.5,62.6,28.8,51.2,14.9,51.2z"/>
        </svg>
      `
    });

    const svgEventIcon = L.divIcon({
      className: "custom-pin",
      html: `
        <svg fill="#e74c3c">
          <circle fill="#DD2E44" cx="10" cy="10" r="10"></circle>
        </svg>
      `
    });

    if (this.usersWithLongLatValue.length > 0) {
      this.usersWithLongLatValue.forEach(user => {
        const userMarker = L.marker([user.latitude, user.longitude], { icon: svgIcon }).addTo(this.map).bindPopup(`User ID: ${user.id}`)
      })
    };

    this.eventsValue.forEach(event => {
      const eventMarker = L.marker([event[1], event[0]], { icon: svgEventIcon }).addTo(this.map).bindPopup(`Event ID: ${event[2]}`)
    })
  }

  updateLocation(lat, lng) {
    this.marker.setLatLng([lat, lng])
    this.map.panTo([lat, lng])
  }

  disconnect() {
    if (this.map) {
      this.map.remove()
    }
  }
}
