
var SketchSettings = SketchSettings || {};

SketchSettings.width  = 256*2
SketchSettings.height = 320
SketchSettings.h_scale = 1
SketchSettings.display = true
SketchSettings.good_brightness = 20
SketchSettings.prepare = function()
{
    scale(SketchSettings.h_scale,1)
}

console.log("imported display settings !")




function reload_page_()
{
  location.reload()
}



function start_timers()
{
  var id = setInterval(reload_page_,30000);
}

//start_timers()
