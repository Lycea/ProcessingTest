

movement =20
color_change = 1
height_max = 150
alpha_ = 0.1

max_points = 7
min_points = 1



class cCurve
{
	constructor()
	{
		this._point_list = []
		
	}

	add(x,y)
	{	
		if(this._point_list.length==0)
		{
			//add it twice
			this._point_list.push([x,y])
		}
		this._point_list.push([x,y])

		this.added = true
	}

	permutatePoint(idx)
	{
		this._point_list[idx][1] = constrain( this._point_list[idx][1]+ random(-movement,movement),height/2-height_max,height/2+height_max)
		
	}

	permutateColor()
	{
		col_ = modu(col_+random(-color_change,color_change),360)
	}

	draw()
	{
		if(this.added == true)
		{
			this.added = false
			this._point_list.sort(function(a,b)
					{
						return a[0]-b[0]
					}
			)
		}

		this.permutateColor()

		beginShape()
			for(var id_point=0;id_point<this._point_list.length;id_point++)
			{
				var point_ = this._point_list[id_point]
				curveVertex(point_[0], point_[1]) 
				this.permutatePoint(id_point)
			}
			
			point_ = this._point_list[this._point_list.length-1]
			curveVertex(point_[0], point_[1])
		curveVertex()
		endShape()
	}
}

var test_curve
var curves =[]
var col_
function setup() 
{
	createCanvas(800,600);
	colorMode(HSL,360,100,100);
	for(i=0;i<1;i++)
	{
		test_curve =new cCurve()
		test_curve.add(0,random(-50,50)+height/2)

		var num_points = floor(random(min_points,max_points));
		var point_diff = width/(num_points+2)
		for(var idx = 1;idx<=num_points;idx++)
		{
			//random points on y
			//let y = random(-50,50)+height/2
			//let x = point_diff*idx //random(-50,50)+height/2
			
			//noise points
			let x = point_diff*idx //random(-50,50)+height/2
			let y = 50
			test_curve.add(x,y)
		}
		test_curve.add(width,random(-50,50)+height/2)
		curves.push(test_curve)
	}
	noFill()

	col_ = random(0,360)
	stroke(col_,70,50,alpha_)
	background(0)
	
}

function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}

function draw()
{
	stroke(col_,70,50,alpha_)
	//background(0)
	for(curve_idx=0;curve_idx<curves.length;curve_idx++)
	{	
		curves[curve_idx].draw()
	}
 //test_curve.draw()
}

function draw_()
{
	stroke(col_,70,50,0.05)
	
	for(var y=0;y<height;y++)
	{
		for(var x=0;x<width;x++)
		{
			color =
			
			distance = modu(dist(x, y, floor(width/2),floor(height/2)),360)
			angle =modu(degrees(atan2(y-floor(height/2),x-floor(width/2))),360)
			
			color = (angle+distance)%30

			if((angle)%2== 0 )
			{
				color = 150
			}

			stroke(color,50,50)
			point(x, y);
		}
	}


}


