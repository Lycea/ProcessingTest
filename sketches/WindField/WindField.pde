var field =[]

var objects =[]

var pixel_per_obj = 20

function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}

class pixel
{
	constructor(){
		this.pos = createVector(random(0,width),random(0,height))	
		this.vel = createVector(0,0)	
		this.acc = createVector(0,0)	
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

		this.prev = this.pos.copy()
	}

	show()
	{
		stroke(0,0)
		fill(0,0.2)
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

			var place = p5.Vector.fromAngle(radians( noise(j/10,i/10,0)*360*2))
			place.setMag(0.1)
			field[i][j]=place
			
		}
	}

	for(var i=0;i<200;i++)
	{
		//objects.push(createVector( random(0, width),random(0,height)))
		objects.push(new pixel())
	}
}


var num = 0

var zoff =0
function draw()
{
	//background(255)
	num = num+0.01
	for(var i=0;i<field.length;i++)
	{
		for(var j=0;j<field[i].length;j++)
		{
			var vec = field[i][j]
			//vec.x = noise(j+sin(num)*10 + 40000)*3
			//vec.y = noise(i+sin(num)*10 + 20000)*3

			//var tmp = createVector(j*pixel_per_obj,i*pixel_per_obj).add(vec*3)
			
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


}