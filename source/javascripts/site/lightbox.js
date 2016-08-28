var ready = function() {
  window.lightbox.init();
};

$(document).on('turbolinks:load', ready);
