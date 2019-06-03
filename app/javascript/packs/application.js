// BOOTSTRAP
import "bootstrap";

// MAPBOX
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
initMapbox()
initAutocomplete()
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

// FLATPICKR
import flatpickr from "flatpickr";
flatpickr(".datepicker")

// TYPEDJS
import initTyped from '../plugins/init_typed';
initTyped()

// FLAT SELECTOR IN THE MAP
import flatSelector from '../plugins/init_flat_selector';
flatSelector()
