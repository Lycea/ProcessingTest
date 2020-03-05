var lines =[]
var y_mod = 0.0124

var n_points = 40

function setup() 
{
	createCanvas(800,600);
	colorMode(HSL,360,100,100);

	for(var i=0;i<n_points;i++)
	{
		lines.push({x:width/2+100,y:height/2,nx:500,ny:500+(i*5)*y_mod,last_x:width/2,last_y:height/2})
	}
	background(0)
	
}

var col = 100
function draw()
{
	//background(0,0.1)
	stroke(col,100,50)
	fill(col,50,50)

	
	for(var i=0;i<lines.length;i++)
	{
		var line_ = lines[i]
		
		//own line
		//line(line_.x,line_.y,line_.last_x,line_.last_y)
		//line to next
		var nxt = lines[(i+1)%n_points]

		line(line_.x,line_.y,nxt.x,nxt.y)

		line(width/2+width/2-line_.x,height/2+height/2-line_.y, width/2+width/2-nxt.x,height/2+height/2-nxt.y)

		//ellipse(line_.x,line_.y,1,1)
		line_.last_x=line_.x
		line_.last_y=line_.y

		var angle =radians( map(noise(line_.nx,line_.ny),-1,1,-360,360) )

		line_.x =3*sin(angle) +line_.x
		line_.y =3*cos(angle) +line_.y
		line_.nx+=y_mod*1

		//line_.x%=width
		//line_.y%=height

		//print(line_)		
	}

	col+=1
	col%=360
}