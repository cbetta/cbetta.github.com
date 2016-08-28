var ready = function() {
  $('#desktop-menu .ui.dropdown').dropdown({
    on: 'hover'
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
