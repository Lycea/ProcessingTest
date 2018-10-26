function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
}

function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}


function draw()
{
	for(var y=0;y<height;y++)
	{
		for(var x=0;x<width;x++)
		{
			color =
			
			distance = modu(dist(x, y, floor(width/2),floor(height/2)),360)
			angle =modu(degrees(atan2(y-floor(height/2),x-floor(width/2))),360)
			
			color = (angle+distance)%30

			if((angle / )%1== 0 )
			{
				color = 150
			}

			stroke(color,50,50)
			point(x, y);
		}
	}

}