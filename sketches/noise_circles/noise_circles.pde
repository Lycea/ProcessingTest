

var circles = [];
var num_circles=10;
var width = 400;
var height = 400;

var noise =[];

function init_noise()
{
	for(var i=0;i<height;i++)
	{
		noise[i]=[]
		for(var j=0;j<width;j++)
		{
			noise[i][j]=  Math.pow(noise(j/100,i/100),0.8) ;
		}
	}
}

function new_circle()
{
	var x;
	var y;
	var size;

	y =random(height/2-50, height/2+50);
	x=random(50,350);
	size = 50;


	return [x,y,size];
}

function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	for(var i =1;i<num_circles;i++)
	{
		circles[circles.length]= new_circle();
	}

	init_noise()
}

function draw_circle(val,idx,ar)
{
	ellipse(val[0],val[1],val[2],val[2]);
}
function draw_noise()
{
	for(var i=0; i<400;i++)
	{
		//print(noise);
		//print(i);
		//print(noise[i])
		for(var j=0;j<400;j++)
		{
			stroke(67,38,noise[j][i]*46+30,100);
			point(j,i)
			
		}
	}
}
var draw_count = 0;
function draw()
{

	if(draw_count==0)
	{
		//background(1);
		draw_noise();
		stroke(255);
		fill(0, 100, 100,0.2);
		circles.forEach(draw_circle);
		draw_count +=1;
	}

	
}