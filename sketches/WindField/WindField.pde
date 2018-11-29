var field =[]

var objects =[]

var pixel_per_obj = 40

function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}

class pixel
{

	create()
	{
		this.pos = createVector(random(0,width),random(0,height))	
		this.vel = createVector(0,0)	
		this.acc = createVector(0,0)
		this.ttl = 40
		this.col = random(0,60)
		this.light = random(25,100)
	}

	constructor(){
		this.create()
	}	

	

	update()
	{
		this.prev = this.pos.copy()
		this.vel= this.vel.add(this.acc)
		this.vel.limit(3)
		this.pos= this.pos.add(this.vel)

		this.pos.x = modu(this.pos.x,width)
		this.pos.y = modu(this.pos.y,height)
		this.acc =createVector(0,0)

		//this.prev = this.pos.copy()
		
		this.ttl-=1
		this.light+=30
		//this.col =+30
		if (this.ttl <=0 )
		{
			this.create()
		}
	}

	show()
	{
		stroke(this.col,this.light,50 ,0)
		//fill(0,0.1)
		fill(this.col,this.light,50 ,0.3)
		rect(this.pos.x,this.pos.y,1,1)

		line(this.pos.x,this.pos.y,this.prev.x,this.prev.y)
	}

	applyForce()
	{
		var g_x = floor(this.pos.x/pixel_per_obj)
		var g_y = floor(this.pos.y/pixel_per_obj)
		
		
		this.acc = this.acc.add(field[g_y][g_x])
	}
}

zoom = 3
function setup() 
{
	createCanvas(800,400);
	colorMode(HSL,360,100,100);

	
	for(var i=0;i<floor(height/pixel_per_obj);i++)
	{
		field[i]=[]
	}
	
	for(var i = 0;i<floor(height/pixel_per_obj);i++)
	{
		for(var j =0;j<floor(width/pixel_per_obj);j++)
		{
			var len = 0
			var vel = 0

			var place = p5.Vector.fromAngle(radians( noise(j/zoom,i/zoom,20/zoom)*400))
			place.setMag(noise(j/(zoom*5)+40000,i/(zoom*5)+40000,20)*2)
			field[i][j]=place
			
		}
	}

	for(var i=0;i<800;i++)
	{
		//objects.push(createVector( random(0, width),random(0,height)))
		objects.push(new pixel())
	}
	background(0)
}


var num = 0

var zoff =0
function draw()
{
	//background(255)
	num = num+0.01
	zoff+=0
	for(var i=0;i<field.length;i++)
	{
		for(var j=0;j<field[i].length;j++)
		{
			mag =field[i][j].mag()
			field[i][j] =p5.Vector.fromAngle(radians( noise(j/zoom,i/zoom,zoff)*400))
			field[i][j].setMag(mag)
			var vec = field[i][j]

			//vec.x = noise(i,j)
			//vec.y = noise(i+sin(num)*10 + 20000)*3

			var tmp = createVector(j*pixel_per_obj,i*pixel_per_obj).add(vec.copy().mult(20))
			//tmp.setMag(0.1)
			
			//stroke(0)
			//line(j*pixel_per_obj,i*pixel_per_obj,tmp.x,tmp.y)
		}
	}

	for(var i=0;i<objects.length;i++)
	{
		
		var obj = objects[i]
		obj.applyForce()
		obj.update()
		
		obj.show()


		//calc the gridpot it is in
		//var g_x = floor(obj.x/pixel_per_obj)
		//var g_y = floor(obj.y/pixel_per_obj)

		//print(field[g_y][g_x],g_x,g_y)
		
		//obj.add(field[g_y][g_x])
		//obj.x = modu(obj.x,width)
		//obj.y = modu(obj.y,height)

		//stroke(i*30,100,50,0.5)
		//ellipse(obj.x,obj.y, 2, 2)

		//point(obj.x,obj.y)

	}

	print(floor(frameRate()))


}