
var SketchSettings = SketchSettings || {};

console.log(screen)
SketchSettings.width  = screen.availWidth;
//SketchSettings.width  = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
SketchSettings.height = screen.availHeight;
//SketchSettings.height = window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;


SketchSettings.prepare = function()
{
    scale(1,1)
}
console.log("imported base settings !")

