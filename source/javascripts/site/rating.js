var ready = function() {
  $('.ui.rating')
    .rating('disable');
};

$(document).ready(ready);
$(document).on('page:load', ready);
