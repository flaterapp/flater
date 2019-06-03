import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
// import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder'; // <-- Not needed (debug from Geocoding-242 Jpheos)
// import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css'; // <-- Not needed (debug from Geocoding-242 Jpheos)

const markersJs = {}

const showMarkerJs = (id) => {
  const markerJs = markersJs[id]
  const popup = markerJs.getPopup()
  if (popup.isOpen() == false)
    markerJs.togglePopup()
}

const hideMarkerJs = (id) => {
  const markerJs = markersJs[id]
  const popup = markerJs.getPopup()
  if (popup.isOpen() == true)
    markerJs.togglePopup()
}

const elementLiOver = (e) => {
  showMarkerJs(e.currentTarget.dataset.flatId)
}

const elementLiOut = (e) => {
  hideMarkerJs(e.currentTarget.dataset.flatId)
}


const initFlatBinding = () => {
  document.querySelectorAll("#flats-map li").forEach((element) => {
    element.addEventListener("mouseover", elementLiOver)
    element.addEventListener("mouseout", elementLiOut)
    element.addEventListener("click", (event) => {
      const path = event.currentTarget.dataset.flatId;
      window.location.href = `/flats/${path}`
    })
  })
}

const initMapbox = () => {
  // SELECT MAP
  const mapElement = document.getElementById('map');

  // DEFINE BOUNDS
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding:200, maxZoom: 16 });
  };
""
  // BUILD MAP // only build a map if there's a div#map to inject into
  if (mapElement) {
    // MAPBOX
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    // DEFINE MARKERS
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((markerData) => {
      const popup = new mapboxgl.Popup()
      .setHTML(markerData.infoWindow);
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${markerData.image_url}')`;
      element.style.width = '32px';
      element.style.height = '48px';

      let markerJs = new mapboxgl.Marker(element)

      markerJs.setLngLat([ markerData.lng, markerData.lat ])
        .setPopup(popup)
        .addTo(map);
      markersJs[markerData.id] = markerJs
    });
    console.log(markersJs)
    // DISPLAY MAP
    fitMapToMarkers(map, markers);
  };
  initFlatBinding();
}


export { initMapbox };
