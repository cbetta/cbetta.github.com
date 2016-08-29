var ready = function() {
  window.lightbox.init();
};

$(document).on('turbolinks:render', ready);
