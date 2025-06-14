//image ref : https://editor.p5js.org/kjhollen/sketches/B1DFjyqez

function setup() 
{
	if (SketchSettings.display == true)
	{
		alpha__ = 20
	}
	else
	{
		alpha__ = 255
	}


	createCanvas(SketchSettings.width,SketchSettings.height, WEBGL );
	
	colorMode(HSL,360,100,100);

	//debugMode();
}

var dist_ = 0
var dist_inc = 0.005



function draw_lanes()
{
	//base plane
	push();
  		rotate(20,[1,0,0])
  		//rotate(dist_/50,[1,0,0])
  		//translate(, -100,dist_);
		translate(0,0,0)
  //texture(img);
  		plane(SketchSettings.width/2, SketchSettings.height);
  	pop();

}

function draw_player()
{
	//draw_lanes()

	push()
		rotate( radians(-20) ,[1,0,0])
		translate(0,0,50)
		box(SketchSettings.width/9,SketchSettings.height/5,20)
	pop()
}

function draw_obstacle()
{

}

function draw()
{
	push()
	SketchSettings.prepare()
    background(0,0,30);   

	//base plane
	push();
  		//rotate(radians(65),[1,0,0])
  		//rotate(dist_/50,[1,0,0])
  		//translate(, -100,dist_);
		
		translate(0,0,-SketchSettings.height/2)
		rotateX(dist_)
  //texture(img);
  		plane(SketchSettings.width, SketchSettings.height);
  	pop();


	//draw_player()
	//draw_obstacle()
	dist_+= dist_inc
  	
	pop()
}