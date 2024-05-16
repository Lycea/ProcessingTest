
var SketchSettings = SketchSettings || {};

SketchSettings.width  = 256*2
SketchSettings.height = 400
SketchSettings.h_scale = 1

SketchSettings.prepare = function()
{
    scale(SketchSettings.h_scale,1)
}

console.log("imported display settings !")
