var docs;

function make_menu() {
  jQuery.getJSON('list.json', function(data){
    docs = data;
    write_links('core');
    write_links('more');
  });
};

function write_links(typ) {
  var list = '';
  var dirs = docs[typ];
  for(dir in dirs) {
    list = list + '<a target="docPane" href="api/' + dirs[dir] + '/index.html">' + dirs[dir] + '</a> <br/>' + "\n";
  };
  e = document.getElementById(typ + 'Menu');
  e.innerHTML = list;
};

