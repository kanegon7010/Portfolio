var isOpen = false;

(() => {
  var navi_toggle = document.getElementById('navi_toggle');
  navi_toggle.addEventListener('click', function() {
    var navi_menu = document.getElementById('navi_menu');
    var navi_wrap = document.getElementById('navi_wrap');
    var navi_open = document.getElementById('navi_open');
    var navi_close = document.getElementById('navi_close');
    if (isOpen === false) {
      navi_menu.className = "block md:block";
      navi_wrap.className = "flex w-full h-screen md:h-screen max-w-xs p-4 bg-gray-800 mx-auto";
      navi_open.className = "hidden";
      navi_close.className = "";
      isOpen = true;
    } else {
      navi_menu.className = "hidden md:block";
      navi_wrap.className = "flex w-full h-auto md:h-screen max-w-xs p-4 bg-gray-800 mx-auto";
      navi_open.className = "";
      navi_close.className = "hidden";
      isOpen = false;
    }
  }, false);
})();