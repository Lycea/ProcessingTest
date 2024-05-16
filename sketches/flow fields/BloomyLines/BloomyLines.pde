let x_start =1
let x_mod = 0.05

let y_start = 1
let y_mod = 0.05

let z = 0
let z_inc = 0.00//0.01

let rec_x_size = 10
let rec_y_size = 10

let x_rects = 800/rec_x_size
let y_rects = 600/rec_y_size

let show_rects = false
let show_lines = false

let point_list =[]

var grid_list =[]

var ttl_base = 999



function rec_size(w,h)
{
	rec_x_size=w
	rex_y_size=h
	refresh()
}

class cListVec
{
	constructor(x,y)
	{
		this.x = x
		this.y = y	

		this.val =0
		this.col = 0

		this.update_val()
	}

	update_val()
	{
		this.val = noise(x_start+x_mod*this.x,y_start+y_mod*this.y,z)
		this.strength = noise(x_start+1000 +x_mod*this.x,y_start-1000+y_mod*this.y,z)**1.5
		//this.col = map(this.val,-1,1,0,360)
	}

	get_val()
	{
		this.update_val()
		return this.val
	}

	show()
	{
		var real_x = this.x * rec_x_size
		var real_y = this.y * rec_y_size
		

		//show a rectangle
		//fill(this.col,50,50)
		//rect(real_x,real_y,rec_x_size,rec_y_size)
		
		//stroke(this.col,50,50)

		var vec_ = createVector(real_x+rec_x_size/2, real_y+rec_y_size/2)

		var x2 = (rec_x_size/2)* sin( radians(this.col) ) +vec_.x
		var y2 = (rec_x_size/2)* cos( radians(this.col) ) +vec_.y

		//show a line
		line(vec_.x,vec_.y,x2,y2)
	}
}

function init_grid()
{
	for(var j =0;j<y_rects;j++)
	{
		grid_list[j] =[]
		for(var i = 0;i<x_rects;i++)
		{
			grid_list[j][i]= new cListVec(i,j)
			//let val =noise(x_start+x_mod*i,y_start+y_mod*j,z)
			//val**=1.5

		}
	}
}

function show_grid()
{
	stroke(255)
	fill(255)
	for(var j =0;j<y_rects;j++)
	{
		for(var i = 0;i<x_rects;i++)
		{
			//grid_list[j][i].update_val()
			grid_list[j][i].show()
		}
	}
}





class cPoint
{
	constructor(x,y)
	{
		this.pos = createVector(x,y)

		this.vel = 0
		this.dir = 0

		this.col = random(150,200)

		this.ttl = ttl_base
	}

	update()
	{
		if(this.ttl <= 0)
		{
			this.ttl=ttl_base
			this.pos = createVector(random(1,width),random(1,height))
			
		}

		var x = min(floor(this.pos.x/rec_x_size),x_rects-1)
		var y = min(floor(this.pos.y/rec_y_size),y_rects-1)
		
		//console.log(y,x)

		grid_list[y][x].update_val()
		

		this.vel =  p5.Vector.fromAngle( grid_list[y][x].val*TWO_PI*2)
		this.pos.add(this.vel)

		if(this.pos.x <=0 ){this.pos.x = width-1}
		if(this.pos.x>=width){this.pos.x = 1}

		if(this.pos.y <=0 ){this.pos.y = height-1}
		if(this.pos.y>=height){this.pos.y = 1}

		this.ttl-=1
	}

	show()
	{	
		fill(this.col,100,50,0.01)
		rect(this.pos.x,this.pos.y,3,3)
		//point(this.pos.x,this.pos.y)
	}
}

function refresh()
{
	//noiseSeed(1)
	x_rects = floor(width/rec_x_size)
	y_rects = floor(height/rec_y_size)

	console.log(y_rects,x_rects)

	init_grid()
	console.log(grid_list)
	console.log("size" ,width,height)

	point_list =[]
	for(var i=0;i<3000;i++)
	{
		point_list.push(new cPoint(random(1,width),random(1,height)))
	}
	background(0)
	noStroke()
}

function setup() 
{
	//createCanvas(1920,1080);
	createCanvas(SketchSettings.width,SketchSettings.height);
	console.log(SketchSettings.width,SketchSettings.height)
	colorMode(HSL,360,100,100);

	


	refresh()

	
}



function draw_mouse()
{
	let x_ = mouseX
	let y_ = mouseY
	

	rect(x_,y_,3,3)
	var g_x = floor(x_ /rec_x_size)
	var g_y = floor(y_/rec_y_size)
	//print(x_,y_)
	rect(g_x*rec_x_size,g_y*rec_y_size,rec_x_size,rec_y_size)
}

function draw()
{	
	SketchSettings.prepare()

	z+=z_inc

	//if debug show the things here
	if(show_lines)
	{

		show_grid()
	}


	
	fill(0,100,70,0.002)
	for(let idx=0;idx<point_list.length;idx++)
	{
		//fill(130,50,50)
		//rect(point_list[idx].x,point_list[idx].y,2,2)
		point_list[idx].update()
		point_list[idx].show()
		//get the angle at this time at this point
		//val =noise(x_start+x_mod* point_list[idx].x/rec_x_size,y_start+y_mod*(point_list[idx].y/rec_y_size),z)
	}



	
	
}
