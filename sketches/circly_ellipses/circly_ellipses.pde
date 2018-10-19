var fill_alpha=0.5

function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);

	fill(100, 50, 50, 0)
	stroke(100,50,50,100)
}

var circ_size= 50

var x_1 = 100
var y_1 = 200

var x_2 = 300
var y_2 = 200
var z=0

var e_width=100
var e_height=20

var ellipses=10
var angle_per= 360-210/ ellipses

function draw()
{
   background(0);
	//draw first and second circle for help
	//ellipse(x_1, y_1, circ_size*2, circ_size*2)
	//ellipse(x_2, y_2, circ_size*2, circ_size*2)

	//draw ellipses at the radius of the first circle
	for(var i =0;i<ellipses;i++)
	{
		fill(100-i*20, 50, 50, fill_alpha)
		stroke(100-i*20,50,50,100)

		var x= circ_size*sin(radians(i*angle_per))+x_1
		var y= circ_size*cos(radians(i*angle_per))+y_1
		
		push()
		translate(x,y)
		rotate(radians(i*30))
		ellipse(0,0,e_width,e_height)
		pop()

		x= (circ_size*1)*sin(radians(i*-angle_per))+x_2
		y= (circ_size*1)*cos(radians(i*-angle_per))+y_2
		
		push()
		translate(x,y)
		rotate(radians(i*-30))
		ellipse(0,0,e_width,e_height)
		pop()
	}
	z+=0.2
	/*translate(width/2,height/2)
	rotate(radians(z))
	ellipse(0,0,30,50)
	*/
}