


var min_size = 70
var max_size = 200
var chitter_devider = 20

var num_circs = 20
var num_circs_devider = 1

var weight=0.2
var alpha_ = 0.3

var circles = 10


function setup() 
{
	createCanvas(800,800);
	colorMode(HSL,360,100,100);
	noLoop()
	noFill()
	strokeWeight(weight)
}


function fill_circ(x,y,size)
{
	var trans =0.05
	var circs = size/10

	noStroke()
	fill(random(0,360),50,50,trans)
	
	for(var i = 0;i<circs;i++)
	{	
		//radius of the smaller circle
		var rad = random(size/15,size)
		do 
		{
			var x_ = random(x-size +rad,x+size -rad)
			var y_ = random(y-size +rad,y+size -rad)

			if(dist(x,y,x_,y_)<size/2)
			{
				ellipse(x_,y_,rad,rad)
				break
			}
		}
		while(true)
	}
	noFill()
}

function draw_circle(idx)
{	
	
	var size = random(min_size,max_size)

	max_chitter = size/chitter_devider
	num_circs   =size/num_circs_devider
	var x = random(size+max_chitter,width-(size+max_chitter))
	var y = random(size+max_chitter,height-(size+max_chitter))
	
	
	ellipse(x,y,5,5)
	

	fill_circ(x,y,size)
	stroke(random(0,360),50,50,alpha_)
	for(var i=0;i<num_circs;i++)
	{
		
		ellipse(x+randomGaussian()*max_chitter, y+randomGaussian()*max_chitter, size+randomGaussian()*max_chitter, size+randomGaussian()*max_chitter)
	}
}

function draw()
{
	for(var i = 0;i<circles;i++)
	{
		draw_circle()
	}
}