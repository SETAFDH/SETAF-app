function Zoom(img, zoom) {
  var loupe, width, height, back;
  /*img = document.getElementById("image");*/
  
  /* Creation of the magnifier glass */
  loupe = document.createElement("div");
  loupe.setAttribute("class", "magnifier-glass");
  
  /* Insertion of the magnifier glass */
  img.parentElement.insertBefore(loupe, img);
  
  /* Background properties for the magnifier */
  loupe.style.backgroundImage = "url('" + img.src + "')";
  loupe.style.backgroundRepeat = "no-repeat";
  loupe.style.backgroundSize = (img.width * zoom) + "px " + (img.height * zoom) + "px";
  back = 2;
  width = loupe.offsetWidth / 2;
  height = loupe.offsetHeight / 2;
  
  /*execute a function when someone moves the magnifier glass over the image:*/
  loupe.addEventListener("mousemove", moveLoupe);
  img.addEventListener("mousemove", moveLoupe);
  
  /*and also for touch screens:*/
  loupe.addEventListener("touchmove", moveLoupe);
  img.addEventListener("touchmove", moveLoupe);
  
  function moveLoupe(e) {
    var pos, x, y;

    e.preventDefault();

    pos = position(e);
    x = pos.x;
    y = pos.y;

    if (x > img.width - (width / zoom)) {x = img.width - (width / zoom);}
    if (x < width / zoom) {x = width / zoom;}
    if (y > img.height - (height / zoom)) {y = img.height - (height / zoom);}
    if (y < height / zoom) {y = height / zoom;}

    loupe.style.left = (x - width) + "px";
    loupe.style.top = (y - height) + "px";
    loupe.style.backgroundPosition = "-" + ((x * zoom) - width + back) + "px -" + ((y * zoom) - height + back) + "px";
  }
  function position(e) {
    var a, x = 0, y = 0;
    e = e || window.event;

    a = img.getBoundingClientRect();
    x = e.pageX - a.left;
    y = e.pageY - a.top;

    x = x - window.pageXOffset;
    y = y - window.pageYOffset;
    return {x : x, y : y};
  }
}