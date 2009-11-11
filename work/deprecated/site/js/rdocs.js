var rdoc = {

  "class" : "association coroutine hashbuilder linkedlist opencascade pathlist reference timer autoarray dictionary heap lrucache opencollection pool rwdelegator tuple basicobject downloader infinity minitar openhash pqueue semaphore version buildingblock filelist interval nackclass openobject progressbar syncarray cachedelegator fileshell ioredirect nullclass orderedhash recorder synchash",

  "more" : "advice annotations ansicode aop arguments attributes autoreload bbcode behavior bytes capsule class_extension classmethods command compare_on console continuation crypt curry cut daemonize date dependency duration elementor eventhook fileutils getoptlong inheritor instantise interface keyize lazy let logger main memoize multipliers namespace ostruct overload paramix pathname prepend prototype random rbconfig rbsystem recursive reflection settings shellwords smtp_tls snapshot stylize thread times tracepoint typecast uploadutils yaml ziputils",

  "write_links": function(typ) {
    var list = '';
    var dirs = rdoc[typ].split(' ');
    for(dir in dirs) {
      list = list + '<a href="rdoc/' + typ + '/' + dirs[dir] + '/index.html">' + dirs[dir] + '</a> | ' + "\n";
    };
    e = document.getElementById(typ + 'Menu');
    e.innerHTML = list;
  },

  "write_options": function(typ) {
    var list = '';
    var dirs = rdoc[typ].split(' ');
    for(dir in dirs) {
      list = list + '<option value="rdoc/' + typ + '/' + dirs[dir] + '">' + dirs[dir] + '</option>' + "\n";
    };
    e = document.getElementById(typ + '_options');
    e.innerHTML = list;
  }

}

