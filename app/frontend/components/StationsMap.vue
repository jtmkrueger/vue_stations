<template>
  <div id="map" />
</template>

<script>
import mapboxgl from 'mapbox-gl'
import 'mapbox-gl/dist/mapbox-gl.css'
import { onMounted } from 'vue'

export default {
  setup () {
    onMounted(() => {
      mapboxgl.accessToken =
        'pk.eyJ1IjoianRta3J1ZWdlciIsImEiOiJjanYxbzB5dDAxd2p5NGRsam00NzNiZWZpIn0.KE64RQSDAtlzsJWhk9W6kg'

      // read latLng from json in html header
      // TODO: kinda redundant as this data is in the geojson
      const latLng = JSON.parse(
        document
          .querySelector('meta[name="geolocation"]')
          .getAttribute('content')
      )

      const geojson = JSON.parse(
        document
          .querySelector('meta[name="stations"]')
          .getAttribute('content')
      )

      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/dark-v9',
        center: [latLng.lng, latLng.lat],
        zoom: 15
      })

      map.on('load', () => {
        console.log("geojson", geojson)
        for (const feature of geojson.features) {
          const el = document.createElement('div')
          el.className = 'marker'

          new mapboxgl.Marker(el)
            .setLngLat(feature.geometry.coordinates)
            .setPopup(
              new mapboxgl.Popup({ offset: 25 }) // add popups
                .setHTML(
                  `<h3>${feature.properties.ev_network}</h3><p>${feature.properties.street_address}</p>`
                )
            )
            .addTo(map)
        }
        // TODO: Here we want to load/setup the popup
      })
    })
    return {}
  }
}
</script>

<style>
#map {
  height: 100vh;
}
</style>
