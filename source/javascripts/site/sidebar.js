var ready = function() {
  $('.ui.sidebar').sidebar('attach events', '.toc.item');
};

$(document).ready(ready);
$(document).on('page:load', ready);
