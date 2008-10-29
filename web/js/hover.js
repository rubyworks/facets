
function hover(thisElem, imgName) {
  ro = document.getElementById('hover');
  ro.posX = thisElem.posX;
  ro.posY = thisElem.posY;
alert(thisElem.posX);
  roi = document.getElementById('hover_img');
  roi.src = imgName;
}

function unhover() {
  ro = document.getElementById('hover');
  ro.style.left = "-200px"
}
