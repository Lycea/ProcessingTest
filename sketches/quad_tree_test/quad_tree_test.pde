

class cRectangle{
	constructor(x,y,width,height)
	{
		this.x=x
		this.y = y
		this.width = width
		this.height = height
	}

	check_inside(point_)
	{
		print(point_)
		ellipse(point_.x,point_.y,5,5)
		print(this.x,this.y)
		print(dist(this.x,0,point_.x,0))
		
		if(dist(this.x,0,point_.x,0)<this.width && dist(this.y,0,point_.y,0)<this.height)
		{
			//print("yes")
			return true
		}

		//print("no")
		return false
	}

	show()
	{
		rect(this.x,this.y,this.width,this.height)
	}
}

class node{
	constructor(boundary,max_points)
	{
		this.is_splitted = false
		this.points =[]
		this.max_points = max_points
		this.boundary = boundary
	}


	show()
	{
		this.boundary.show()
		if(this.is_splitted)
		{
			this.ne.show()
			this.nw.show()
			this.se.show()
			this.sw.show()
		}
		for(let point_ in this.points)
		{
			ellipse(point_.x,point_.y,5,5)
		}
	}

	addPointToSplitted(point_)
	{
		this.ne.addPoint(point_)
		this.nw.addPoint(point_)
		this.se.addPoint(point_)
		this.sw.addPoint(point_)
	}

	addPoint(point_)
	{	
		if(this.boundary.check_inside(point_)==false)
		{
			return
		}
		if(this.is_splitted == true)
		{
			this.addPointToSplitted(point_)
		}
		else
		{
			if(this.points.length+1 >this.max_points && this.is_splitted ==false)
			{
				var bond = this.boundary
				print("---------------------------splitting---------")
				this.is_splitted = true
				this.ne = new node(new cRectangle(bond.x+bond.width/2,bond.y,bond.width/2,bond.height/2),this.max_points)
				//print(this.ne.boundary)
				this.nw = new node(new cRectangle(bond.x,bond.y,bond.width/2,bond.height/2),this.max_points)
				//print(this.nw.boundary)
				this.se = new node(new cRectangle(bond.x+bond.width/2,bond.y+bond.height,bond.width/2,bond.height/2),this.max_points)
				//print(this.se.boundary)
				this.sw = new node(new cRectangle(bond.x,bond.y+bond.height,bond.width/2,bond.height/2),this.max_points)
				//print(this.sw.boundary)
				print("------------------splitt end ---------")
				this.addPointToSplitted(point_)
			}
			else
			{
				this.points.push(point_)
			}
		}
	}
}

var tree =""
function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);

	tree= new node(new cRectangle(0,0,width,height),5)
}


function draw()
{
	background(0)
	noFill()
	stroke(255)

	


	tree.show()
}

function mouseClicked()
{
	tree.addPoint({x:mouseX,y:mouseY})
}