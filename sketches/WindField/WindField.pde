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

	create()
	{
		this.pos = createVector(random(0,width),random(0,height))	
		this.vel = createVector(0,0)	
		this.acc = createVector(0,0)
		this.ttl = 99999999
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
		//this.col = (this.col+1)%360
		if (this.ttl <=0 )
		{
			this.create()
		}
	}

	show()
	{
		stroke(this.col,this.light,50 ,1)
		//fill(0,0.1)
		fill(this.col,this.light,50 ,1)
		rect(this.pos.x,this.pos.y,3,3)

		//line(this.pos.x,this.pos.y,this.prev.x,this.prev.y)
	}

	applyForce()
	{
		var g_x = floor(this.pos.x/pixel_per_obj)
		var g_y = floor(this.pos.y/pixel_per_obj)
		
		
		this.acc = this.acc.add(field[g_y][g_x])
	}
}

zoom = 10
angle = 400
mag_factor = 5

var settings =0


function cb_all(something)
{
	//set the value to the actualised value :P
	window[something]=settings.getValue(something)
}

function setup() 
{
	
	createCanvas(800,400);
	colorMode(HSL,360,100,100);

	noiseSeed(1)

	settings = QuickSettings.create(0,0,"FieldParams")
	settings.addRange("zoom",0,100,zoom,0.5)
	settings.addRange("angle",0,1000,angle,0.5)
	settings.addRange("mag_factor",0,100,mag_factor,0.5)
	print(settings)


	settings.setGlobalChangeHandler(cb_all)
	/*gui = createGui("p5.gui")
	gui.addGlobals("zoom")
	gui.addGlobals("angle")
	gui.addGlobals("mag_factor")
	*/



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

			var place = p5.Vector.fromAngle(radians( noise(j/zoom,i/zoom,20/zoom)*angle))
			place.setMag(noise(j/(zoom*mag_factor)+40000,i/(zoom*mag_factor)+40000,20)/2)
			field[i][j]=place
			
		}
	}

	for(var i=0;i<100;i++)
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
	background(255)
	num = num+0.01
	//zoff+=0.05
	for(var i=0;i<field.length;i++)
	{
		for(var j=0;j<field[i].length;j++)
		{
			mag =field[i][j].mag()
			//field[i][j] =p5.Vector.fromAngle(radians( noise(j/zoom,i/zoom,zoff/zoom)*400))
			//field[i][j].setMag(mag)
			var vec = field[i][j]

			//vec.x = noise(i,j)
			//vec.y = noise(i+sin(num)*10 + 20000)*3

			
			//tmp.setMag(0.1)

			vec = p5.Vector.fromAngle(radians( noise(j/zoom,i/zoom,zoff/zoom)*angle))
			vec.setMag(noise(j/(zoom*mag_factor)+40000,i/(zoom*mag_factor)+40000,zoff/(zoom*mag_factor))/2)

			var tmp = createVector(j*pixel_per_obj,i*pixel_per_obj).add(vec.copy().mult(30))
			
			stroke(0)
		    line(j*pixel_per_obj,i*pixel_per_obj,tmp.x,tmp.y)
		}
	}

	for(var i=0;i<objects.length;i++)
	{
		
		var obj = objects[i]
		obj.applyForce()
		obj.update()
		
		//obj.show()


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

	//print(floor(frameRate()))


}