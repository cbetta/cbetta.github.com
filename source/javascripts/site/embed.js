var ready = function() {
  $('.ui.embed').embed();
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
