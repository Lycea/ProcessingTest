var array_points=[]
var start_points = 3000

var points_used=[]

var variation = 3

var redStatic = 0
var blueStatic = 0
var greenStatuc = 0

var base_rad = 30


var col = 0
var light = 50

count = 0

function new_point()
{
	var tmp =[]
    var start = floor(random(360))
	
	
	tmp.x = base_rad*sin(start)+width/2
	tmp.y = base_rad*cos(start)+height/2
	tmp.angle=floor(random(360))

	
	tmp.prev_x = tmp.x
	tmp.prev_y = tmp.y

	tmp.h = col
	tmp.s = 50
	tmp.l = light
	if(count>4000)
	{
		if(random(1000)>600)
		{
			light = 0
		}
		else
		{
			col=random(360)//(col +10)%360
			light = 50
		}
		count = 0
	}
	count+=1
	points_used.push([tmp[0],tmp[1]])
	return tmp
}

function setup() 
{
	createCanvas(1680,1240);
	colorMode(HSL,360,100,100);
	for(var i = 0;i<height;i++)
	{
		points_used[i]=[]
	}

	for(var i=0;i<start_points;i++)
	{
		array_points.push(new_point())
	}
	
	//noFill()
	background(0)
}

var angle_p_slice = 360/8
var speed = 7
var diff_angle = 0.1

function add_changed_point(point_)
{
	var tmp = []

	tmp.prev_x = point_.x
	tmp.prev_y = point_.y

	tmp.angle = point_.angle +random(-diff_angle,diff_angle)
	tmp.x = speed*sin(point_.angle)+point_.x
	tmp.y = speed*cos(point_.angle)+point_.y

	tmp.h = point_.h
	tmp.s = point_.s
	tmp.l = point_.l

	//print(point_)
	return tmp
}

function dist1d(x,y)
{
  return  abs(x-y)
}



function draw()
{
	strokeWeight(0.3)
	
	var len_start = array_points.length
	//print(len_start/10)
	for(var num =0; num <start_points;num++ )
	{
		var len_array = array_points.length


		random_idx = floor(random(0,len_array-1))
		var point_ = array_points[random_idx]

		stroke(point_.h,point_.s,point_.l)
		fill(point_.h,point_.s,point_.l)
	
		
		
		line(point_.x,point_.y,point_.prev_x,point_.prev_y)

		if(dist1d(point_.x,width/2)>width/2 || dist1d(point_.y,height/2)>height/2)
		{
			new_p=new_point()
		}	
		else
		{
			new_p =add_changed_point(point_)		
			
		}	
		array_points.push(new_p)

		
		array_points.splice(random_idx,1)
	}
	last_process = second()

	print(frameRate())
}