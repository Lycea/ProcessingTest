var base_col =0
function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	base_col =random(0,250)
	noLoop()
}


function hexagon(x,y,size)
{
	line_size =size
	//line_size = random(10,50)

	line_size

	//x= random(line_size,width-line_size)
	//y= random(line_size,height-line_size)
	strokeWeight(2)
	fill(base_col,random(25,75),random(25,75),1)
	beginShape()
		vertex(x,y)//left
		vertex(x+line_size*0.5,y-line_size)//up left
		vertex(x+line_size*1.5,y-line_size)//up right
		vertex(x+line_size*2,y)//right
		vertex(x+line_size*1.5,y+line_size)//down right
		vertex(x+line_size*0.5,y+line_size)//down left
		vertex(x,y)//left
	endShape()
}

function draw()
{
	
	size = random(5,20)

	rows= height/size*2
	collumns = width/(size*2)
	for(var line =0;line<rows;line++)
	{
		for(var hex=0;hex<collumns;hex++)
		{
			offset_x=(line%2)*(size*1.5) - size
			
			hexagon(offset_x+hex*(size*3),line*size+size -size,size)
		}
	}
	

}