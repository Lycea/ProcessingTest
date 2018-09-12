

var grid=[]
var pos=[200,200]

var ant_dir = 270

var wait = 0
var wait_num = 0

var src_w = 200
var src_h = 200

var btn_reset
var sli_width
var sli_height

var canvas

var scale_ =1
var ppscale //pixel per scale grid
var grid_pos_x
var grid_pos_y




function ini_canv()
{
	createCanvas(src_w,src_h);
	colorMode(HSL,360,100,100);

	canvas =createGraphics(width,height);
	canvas.colorMode(HSL,360,100,100);

	ppscale = floor( width/scale_)
	grid_pos_x = floor(pos[0]/ppscale)
	grid_pos_y = floor(pos[1]/ppscale)

	print([grid_pos_x,grid_pos_y])

}

function ini_ant()
{
	canvas.fill(360,0,0,1)
	pos=[floor(width/2+0.5),floor(height/2+0.5)]
	canvas.rect(0,0,width,height);
	canvas.noSmooth()
	canvas.noStroke()


	for( var i = 0; i<height;i++)
	{	
		grid[i]=[]
		for(var j=0;j<width;j++)
		{
			grid[i][j]=0
		}
	}
}


function ini_control_positions()
{
	btn_reset.position(0,height+20)
	sli_width.position(0,height+60)
}

function changed_slider_w()
{
	src_w =sli_width.value()
	src_h = src_w
	print(sli_width.value())
	ini_canv()
	ini_ant()
	ini_control_positions()
}

function setup() 
{
	ini_canv()	

	ini_ant()

	
	//btn_reset =createButton("reset", 1)
	//btn_reset.mousePressed(ini_ant)
	

	//sli_width = createSlider(100, 800, src_w, 1)
	//sli_width.changed(changed_slider_w)

	//ini_control_positions()
}





function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}


function draw()
{	
	fill(0,0,0,0)
	rect(0,0,width,width)
	for(var i=0;i<20;i++)
	{
		pos_col =grid[pos[1]][pos[0]]
		
		//print(second())
		canvas.fill(pos_col+1,50,50)

		grid[pos[1]][pos[0]]= (grid[pos[1]][pos[0]] +5)%360


		canvas.rect(pos[0],pos[1],1,1)
		grid_pos_x = floor(pos[0]/ppscale)
		grid_pos_y = floor(pos[1]/ppscale)
		

		push()
		scale(scale_,scale_)
		print(grid_pos_x*ppscale)
		translate((grid_pos_x*ppscale)*-1,(grid_pos_y*ppscale)*-1)
		image(canvas,0,0)
		pop()
	
		/*if(pos_col%2==1)
		{
			ant_dir -=90
		}
		else
		{
			ant_dir +=90
		}
	*/

		ant_dir = ant_dir+map(pos_col%2,0,1,-1,1)*-90
		var x= floor(pos[0]+ Math.sin(radians(ant_dir))*1 +0.5)
		var y= floor(pos[1]+ Math.cos(radians(ant_dir))*1 +0.5)
		//print(x ,y)

		pos[0]=modu(x,width-1)//x%width
		pos[1]=modu(y,height-1)//y%height	
		

		
	}	
}