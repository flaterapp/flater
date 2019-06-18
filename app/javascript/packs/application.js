// BOOTSTRAP
import 'bootstrap';

// COPY TO CLIPBOARD
import { initCopyToClipboard } from '../plugins/init_copy_to_clipboard';
initCopyToClipboard()

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


// AUTOSCROLL FOR MESSAGES
import { scrollLastMessageIntoView } from '../plugins/init_autoscroll_messages';
//= require jquery
//= require jquery_ujs
//= require_tree .

(function() {
  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');

    panel.find('.panel-body').toggle();
    panel.attr('class', 'panel panel-default');

    if (panel.find('.panel-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();
