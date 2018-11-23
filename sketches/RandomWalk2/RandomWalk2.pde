var array_points=[]
var start_points = 1

var points_used=[]

function new_point()
{
	var tmp =[]
	tmp.x = floor( width/2)
	tmp.y = floor(height/2)
	tmp.h = 100
	tmp.s = 100
	tmp.l = 50

	points_used.push([tmp[0],tmp[1]])
	return tmp
}

function setup() 
{
	createCanvas(400,400);
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
}



function add_changed_point(point_,x,y)
{
	var tmp = []

	tmp.x = x
	tmp.y = y

	tmp.s = point_.s 
	tmp.l = point_.l +random(0,100)/100
	tmp.h = point_.h +random(0,200)/50

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
	for(var num =0; num <ceil(len_start/10);num++ )
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
				
				
				info =points_used[point_.y+i][point_.x+j]
				if (info || dist1d(point_.x+j,width/2)>width/2||dist1d(point_.y+i,height/2)>height/2)
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