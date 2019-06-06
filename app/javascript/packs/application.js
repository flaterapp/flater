// BOOTSTRAP
import 'bootstrap';

// COPY TO CLIPBOARD
import { initCopyToClipboard } from '../plugins/init_copy_to_clipboard';
initCopyToClipboard()

import { copy } from '../plugins/copy';
copy()


// FLATPICKR
import flatpickr from 'flatpickr';
flatpickr('.datepicker')

// MAPBOX
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
initMapbox()
initAutocomplete()

// TYPEDJS
import initTyped from '../plugins/init_typed';
import { addFlashMessage } from '../plugins/init_flash_messages';
initTyped()


