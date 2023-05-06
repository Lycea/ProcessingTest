var scr_w = 400
var scr_h = 400






function gen_birb()
{
	var mid = createVector(scr_w/2,scr_h/2)

	ellipse(mid.x,mid.y,40,40)

	
}

function setup() 
{
	createCanvas(scr_w,scr_h);
	colorMode(HSL,360,100,100);
}


function draw()
{
	gen_birb()

}