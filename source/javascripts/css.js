var cb = function() {
  var noscript = document.getElementsByTagName("noscript")[0];
  link = noscript.innerHTML.split('"')[1];
  var l = document.createElement('link'); l.rel = 'stylesheet';
  l.href = link;
  var h = document.getElementsByTagName('head')[0];
  h.parentNode.insertBefore(l, h);
};
var raf = requestAnimationFrame || mozRequestAnimationFrame ||
    webkitRequestAnimationFrame || msRequestAnimationFrame;
if (raf) raf(cb);
else window.addEventListener('load', cb);
