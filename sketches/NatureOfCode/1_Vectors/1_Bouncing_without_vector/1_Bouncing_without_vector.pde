class cBall
{
	constructor(x,y)
	{
		this.x = x
		this.y = y

		this.x_dir = random(1,2)
		this.y_dir = random(1,2)

		this.col = random(0,360)
	}

	show()
	{	
		fill(this.col,50,50,0.3)
		ellipse(this.x,this.y,10,10)
	}

	update()
	{
		this.x+=this.x_dir
		this.y+=this.y_dir

		if(this.x<0 || this.x >width)
		{
			this.x_dir*=-1
		}
		if(this.y<0|| this.y >height)
		{
			this.y_dir*=-1
		}
	}
}

let balls =[]

function setup() 
{	
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	noStroke()
	for(var i=0;i<50;i++)
	{
		balls.push(new cBall(random(0,400),random(0,400)))
	}

}



function draw()
{	
	background(0,0.1)
	for(let i=0;i<balls.length;i++)
	{
		balls[i].update()
		balls[i].show()
	}

}