import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
// import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder'; // <-- Not needed (debug from Geocoding-242 Jpheos)
// import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css'; // <-- Not needed (debug from Geocoding-242 Jpheos)

const initMapbox = () => {
  // SELECT MAP
  const mapElement = document.getElementById('map');

  // DEFINE BOUNDS
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 200, maxZoom: 15 });
  };

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
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
    // DISPLAY MAP
    fitMapToMarkers(map, markers);
  };
};

export { initMapbox };
