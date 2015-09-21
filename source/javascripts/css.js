var cb = function() {
  var noscript = document.getElementsByTagName("noscript")[0];
  var frag = document.createDocumentFragment(),
  tmp = document.createElement('body'), child;
  tmp.innerHTML = noscript.innerText;
  while (child = tmp.firstChild) {
    frag.appendChild(child);
  }
  var h = document.getElementsByTagName('head')[0];
  h.appendChild(frag);
};
var raf = requestAnimationFrame || mozRequestAnimationFrame ||
    webkitRequestAnimationFrame || msRequestAnimationFrame;
if (raf) raf(cb);
else window.addEventListener('load', cb);
