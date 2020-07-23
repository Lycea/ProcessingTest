class cBall
{
	constructor(x,y)
	{
		this.pos = createVector(x,y)

		this.speed = createVector(random(1,2), random(1,2))

		this.col = random(0,360)
	}

	show()
	{	
		fill(this.col,50,50,0.3)
		ellipse(this.pos.x,this.pos.y,10,10)
	}

	update()
	{
		this.pos.add(this.speed)

		if(this.pos.x<0 || this.pos.x >width)
		{
			this.speed.x*=-1
		}
		if(this.pos.y<0|| this.pos.y >height)
		{
			this.speed.y*=-1
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