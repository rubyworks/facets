function lookup(elem, key) {
alert(key);
  if ($(elem).hasClass('trigger')) {
    $(elem).attr('display', 'block');
    $('#main').load(key);
  } else {
    $('#main').load(key);
  };
};

function lookup_static(elem, file) {
  if ($(elem).hasClass('trigger')) {
    $(elem).attr('display', 'block');
    $('#main').load(file);
  } else {
    $('#main').load(file);
  };
};

function showBranch(trigger) {
  var objTrigger = $(trigger);
  var objBranch  = objTrigger.siblings('.branch');
  if(objBranch.css('display') == "block") {
    objBranch.css('display', "none");
  } else {
    objBranch.css('display', "block");
  }
};

function swapFolder(img) {
  objImg = document.getElementById(img);
  if(objImg.src.indexOf('closed.gif')>-1) {
    objImg.src = openImg.src;
  } else {
    objImg.src = closedImg.src;
  }
};

function getWindowHeight() {
  var windowHeight = 0;
  if (typeof(window.innerHeight) == 'number') {
    windowHeight = window.innerHeight;
  }
  else {
    if (document.documentElement && document.documentElement.clientHeight) {
      windowHeight = document.documentElement.clientHeight;
    }
    else {
      if (document.body && document.body.clientHeight) {
        windowHeight = document.body.clientHeight;
      }
    }
  }
  return windowHeight;
};

function resizePage() {
  var side = document.getElementById('tree');
  var main = document.getElementById('main');
  var h = getWindowHeight();
  var nh = (h - 134) + 'px';
  side.style.height = nh;
  main.style.height = nh;
};

