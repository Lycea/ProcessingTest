var array_points=[]
var start_points = 1

var points_used=[]

var variation = 3

var redStatic = 0
var blueStatic = 0
var greenStatuc = 0


function new_point()
{
	var tmp =[]
	tmp.x = floor(width/2)
	tmp.y = floor(height/2)
	tmp.h = random(0,255)
	tmp.s = random(0,255)
	tmp.l = random(0,255)

	points_used.push([tmp[0],tmp[1]])
	print(tmp)
	return tmp
}

function setup() 
{
	createCanvas(1920,1080);
	colorMode(RGB,255,255,255);
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



function add_changed_point(point_,x,y)
{
	var tmp = []

	tmp.x = x
	tmp.y = y

	
	tmp.h = point_.h +randomGaussian()*variation //r
	tmp.s = point_.s +randomGaussian()*variation
	tmp.l = point_.l +randomGaussian()*variation

	//print(point_)
	return tmp
}

function dist1d(x,y)
{
  return  abs(x-y)
}

var last_process=0
var once = false
function draw()
{
	
	var len_start = array_points.length
	//print(len_start/10)
	for(var num =0; num <min(ceil(len_start/10),1000);num++ )
	{
		var len_array = array_points.length

	
		random_idx = floor(random(0,len_array-1))
		var point_ = array_points[random_idx]

		stroke(point_.h,point_.s,point_.l)
		fill(point_.h,point_.s,point_.l)
		

		//point(300,300)
		
		
		rect(point_.x,point_.y,1,1)
		for(var i=-1;i<2;i++)
		{
			for(var j=-1;j<2;j++)
			{
				if(i == 0 && j == 0)
				{
					continue
				}
				
				if(dist1d(width/2,point_.x)>=width/2||dist1d(height/2,point_.y)>=height/2)
				{
					continue
				}

				info =points_used[point_.y+i][point_.x+j]
				if (info )
				{
					continue
				}  
				
				new_p =add_changed_point(point_,point_.x+j,point_.y+i)
				
				
				points_used[point_.y+i][point_.x+j]=true
				array_points.push(new_p)
				
			}
		}
		points_used[point_.y][point_.x]=true
		array_points.splice(random_idx,1)
	}
	last_process = second()

}