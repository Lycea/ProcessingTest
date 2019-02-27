
function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}

class mover
{
	
  constructor(x,y,z)
  {
	this.x = x
	this.y = y
	this.z = z

	this.dir = floor(random(0,dirs.length))
	this.steps_for_dir = random(0,50)
	this.steps = 0
	this.speed = 3
	this.col = random(0,360)
  }

  move()
  {
	if( this.steps < this.steps_for_dir )
	{
		this.x = modu(this.x+this.speed*dirs[this.dir][0],width);
		this.y = modu(this.y+this.speed*dirs[this.dir][1],height);
		this.z = modu(this.z+this.speed*dirs[this.dir][2],400);
		this.steps+=1
	}
	else
	{
		this.dir = floor(random(0,dirs.length))
		this.steps_for_dir = random(0,50)
		this.steps = 0
	}
  }

  draw()
  {
	  push()
		fill(this.col,30,50)
		stroke(this.col,55,55) 
		

		rotateX(1)
		rotateY(0)
		rotateZ(0)
	  	translate(-width/2,-height/2)
		translate(this.x,this.y,this.z)
		
		box(3,3,3)
	    //this.col=(this.col+1)%360
		  
	  pop()
  }
}

points_ =[]
function setup() 
{
	createCanvas(400,400,WEBGL);
	colorMode(HSL,360,100,100);
	for(i=0;i<10;i++)
	{
		points_.push(new mover(random(30,width-30),random(30,height-30),random(-50,450)))
	}
	background(0)
}

let rotation_x = 0;
let rotation_y = 0;
let rotation_z = 0;

let dirs=[
	[1,0,0],
	[-1,0,0],
	[0,1,0],
	[0,-1,0],
	[0,0,1],
	[0,0,-1]
]



function draw()
{
	noStroke()
	
	//background(0)
	for(i=0;i<points_.length;i++)
	{
		points_[i].move()
		points_[i].draw()
	}
}
function draw_()
{
	background(40,0,0,0.5);

	for (i=0;i<10;i++)
	{
	fill(sin((rotation_x+rotation_y+rotation_z)/3*0.1)*350+i*10 ,50,50);
	
	push()
		translate(-width/2+30,-height/2+30)
		translate(i* 50,i*50,i*-10*sin(rotation_x))
		rotateX(rotation_x);
		rotateY(rotation_y);
		rotateZ(rotation_z);
		
		box(30);
	pop()

	push()
		translate(width/2-30,-height/2+30)
		translate(-i*50,i*50)
		rotateX(-rotation_x);
		rotateY(-rotation_y);
		rotateZ(-rotation_z);
		
		box(25);
	pop()

	rotation_x+=0.03/10;
	rotation_y+=0.05/10;
	rotation_z+=0.07/10;
	}
}